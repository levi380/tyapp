import 'dart:io';
import 'dart:io' as io;

typedef DomainIpResolver = Future<String?> Function(String host);
typedef DomainIpCacheGetter = String? Function(String host);
typedef DomainIpCacheSetter = void Function(String host, String ip);

class DirectIpConnectionFactory {
  DirectIpConnectionFactory._();

  static Future<ConnectionTask<Socket>> create({
    required Uri uri,
    required String? proxyHost,
    required int? proxyPort,
    DomainIpResolver? resolver,
    DomainIpCacheGetter? cacheGetter,
    DomainIpCacheSetter? cacheSetter,
    bool enableSystemLookup = false,
  }) async {
    if (proxyHost != null && proxyPort != null) {
      return Socket.startConnect(proxyHost, proxyPort);
    }

    final targetPort = uri.hasPort
        ? uri.port
        : (uri.isScheme('https')
            ? io.HttpClient.defaultHttpsPort
            : io.HttpClient.defaultHttpPort);

    InternetAddress? targetIpAddress = InternetAddress.tryParse(uri.host);

    if (targetIpAddress == null && cacheGetter != null) {
      final cachedIp = cacheGetter(uri.host);
      if (cachedIp != null && cachedIp.isNotEmpty) {
        targetIpAddress = InternetAddress.tryParse(cachedIp);
      }
    }

    if (targetIpAddress == null && resolver != null) {
      try {
        final resolvedIp = await resolver(uri.host);
        if (resolvedIp != null && resolvedIp.isNotEmpty) {
          targetIpAddress = InternetAddress.tryParse(resolvedIp);
          if (targetIpAddress != null && cacheSetter != null) {
            cacheSetter(uri.host, targetIpAddress.address);
          }
        }
      } catch (_) {
        // Ignore resolver failures and fallback to hostname connect.
      }
    }

    if (targetIpAddress == null && enableSystemLookup) {
      try {
        final addresses = await InternetAddress.lookup(uri.host);
        if (addresses.isNotEmpty) {
          targetIpAddress = addresses.first;
          if (cacheSetter != null) {
            cacheSetter(uri.host, targetIpAddress.address);
          }
        }
      } catch (_) {
        // Ignore DNS failures and fallback to hostname connect.
      }
    }

    if (uri.isScheme('https') && targetIpAddress != null) {
      final tcpTask = await Socket.startConnect(targetIpAddress, targetPort);
      final secureFuture = tcpTask.socket.then(
        (Socket plain) => SecureSocket.secure(
          plain,
          host: uri.host,
          onBadCertificate: (X509Certificate _) => true,
        ),
      );
      return ConnectionTask.fromSocket<Socket>(secureFuture, tcpTask.cancel);
    }

    if (targetIpAddress != null) {
      return Socket.startConnect(targetIpAddress, targetPort);
    }
    return Socket.startConnect(uri.host, targetPort);
  }
}
