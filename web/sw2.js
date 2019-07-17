// sw.js
self.addEventListener('install', e => {
 e.waitUntil(
   // after the service worker is installed,
   // open a new cache
   caches.open('v2.1').then(cache => {
     // add all URLs of resources we want to cache
     return cache.addAll([
       '/',
'/main.dart.js',
'/index.html',
'/site.webmanifest?v=pge6aPK2W4',
'/favicon.ico?v=pge6aPK2W4',
'/favicon-32x32.png?v=pge6aPK2W4',
'/favicon-16x16.png?v=pge6aPK2W4',
'/android-chrome-192x192.png?v=pge6aPK2W4',
'/android-chrome-512x512.png?v=pge6aPK2W4',
'/apple-touch-icon.png',
'/browserconfig.xml',
'/favicon.ico',
'/mstile-150x150.png',
'/safari-pinned-tab.svg',
'/assets/FontManifest.json',
'/assets/fonts/MaterialIcons-Regular.ttf',
'/assets/assets/icon/icon.png',
     ]);
   })
 );
});

self.addEventListener('activate', function(event) {
  console.log('activate');
  var cacheKeeplist = ['v2.1'];
  event.waitUntil(
    caches.keys().then(function(keyList) {
      return Promise.all(keyList.map(function(key) {
        if (cacheKeeplist.indexOf(key) === -1) {
          return caches.delete(key);
        }
      }));
    })
  );
});

self.addEventListener('fetch', function(event) {
  console.log('fetch: ' + event.request.url);

  const ignoreUrls = [
    '/login',
    '/static/js/app.js'
  ];
  const url = new URL(event.request.url);
  if (ignoreUrls.indexOf(url.pathname) > -1) {
    console.log('ignore');
    return
  }

  // https://developers.google.com/web/ilt/pwa/caching-files-with-service-worker
  event.respondWith(
    // Cache falling back to the network
    caches.match(event.request).then(function(response) {
      return response || fetch(event.request);
    })
  );
});
