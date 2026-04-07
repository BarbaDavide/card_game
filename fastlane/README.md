# Fastlane Configuration

Questa cartella contiene la configurazione per automatizzare il deploy dell'app.

## Prerequisiti

1. Installare fastlane:
```bash
sudo gem install fastlane
```

2. Per iOS, configurare i certificati e provisioning profile

3. Per Android, avere il keystore pronto

## Configurazione

### iOS
```bash
cd ios
fastlane init
```

### Android
```bash
cd android
fastlane init
```

## Comandi Utili

### iOS
- `fastlane ios beta`: Build e upload a TestFlight
- `fastlane ios release`: Build e upload ad App Store
- `fastlane ios screenshots`: Genera screenshot

### Android
- `fastlane android beta`: Build e upload a Play Store (track interno)
- `fastlane android release`: Build e upload a Play Store (produzione)

## Note

- I file sensibili (keystore, password) NON devono essere commitati
- Usare variabili d'ambiente per le credenziali
- Backuppare sempre il keystore Android in luogo sicuro
