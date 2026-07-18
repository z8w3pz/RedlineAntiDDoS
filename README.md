# Redline Anti-DDoS & Rate Limiter

FiveM sunucuları için geliştirilmiş, bağlantı aşamasında (connection phase) gerçekleşen flood ve DDoS saldırılarını engellemeye yönelik hafif ve etkili bir koruma scriptidir. 

Bu proje **RedlineShare** tarafından yapılmıştır.

## 🛠️ Ne İşe Yarıyor?
* **Bağlantı Flood Koruması (Connection Flood Protection):** Kısa süre içinde aynı IP üzerinden gelen aşırı bağlantı isteklerini (bot saldırıları, sahte oyuncu girişleri) tespit eder.
* **Geçici IP Engelleme (Dynamic Blacklisting):** Belirlenen limiti aşan IP adreslerini otomatik olarak kara listeye alır ve sunucuya erişimini belirli bir süre (örneğin 5 dakika) boyunca tamamen kapatır.
* **Performans Dostu (Resource Friendly):** Sunucu işlemcisini yormadan, daha oyuncu sunucuya tamamen dahil olmadan (deferrals aşamasında) filtreleme yapar.

## 🚀 Nasıl Kurulur?

1. Bu depoyu (repository) bilgisayarınıza indirin veya kopyalayın.
2. Sunucunuzun `resources` klasörünün içine `redline-anti-ddos` adında yeni bir klasör oluşturun.
3. İndirdiğiniz `fxmanifest.lua` ve `server.lua` dosyalarını bu klasörün içine atın.
4. `server.cfg` dosyanızı açın ve aşağıdaki satırı ekleyin:
   ```fxscript
   ensure redline-anti-ddos
