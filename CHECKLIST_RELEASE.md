# Checklist di Rilascio - Rogue Card Game

## PRE-RELEASE

### Sviluppo e Testing
- [ ] Tutti i test unitari passano (`flutter test`)
- [ ] Test widget completati per schermate principali
- [ ] Integration test per flussi critici (nuova partita, salvataggio, combattimento)
- [ ] Code coverage >= 80%
- [ ] Nessuna warning nel build (`flutter analyze`)
- [ ] Performance test su dispositivi vecchi (60 FPS stabili)
- [ ] Memory leak check con DevTools
- [ ] Test accessibilità (VoiceOver/TalkBack)

### Asset e Localizzazione
- [ ] Tutte le stringhe localizzate (IT/EN)
- [ ] Screenshot reali del gameplay (5.5" e 6.5")
- [ ] Icona app in tutte le dimensioni
- [ ] Splash screen testato
- [ ] Audio testato con e senza cuffie
- [ ] Font loading verificato

### Sicurezza e Privacy
- [ ] PrivacyInfo.xcprivacy configurato (iOS)
- [ ] Privacy Policy aggiornata
- [ ] Crittografia dati sensibili attiva
- [ ] Funzione "Reset dati" testata
- [ ] Nessun dato trasmesso in rete (verificare con proxy)

### Configurazione Piattaforme

#### iOS
- [ ] Bundle ID configurato correttamente
- [ ] Versione e build number incrementati
- [ ] Info.plist completo (descrizione, permessi)
- [ ] Entitlements configurati
- [ ] Test su dispositivo fisico
- [ ] Archive build riuscito
- [ ] Validazione App Store Connect

#### Android
- [ ] Application ID configurato
- [ ] Keystore generato e backuppato SICURAMENTE
- [ ] android:versionCode incrementato
- [ ] android:versionName aggiornato
- [ ] ProGuard/R8 abilitato per release
- [ ] Build APK e AAB testati
- [ ] Test su diversi dispositivi Android

### Metadati Store

#### App Store (iOS)
- [ ] Titolo (max 30 caratteri)
- [ ] Sottotitolo (max 30 caratteri)
- [ ] Descrizione (max 4000 caratteri)
- [ ] Keywords (max 100 caratteri)
- [ ] Categoria primaria e secondaria
- [ ] Rating age (4+, 9+, 12+, 17+)
- [ ] Screenshot per tutti i device richiesti
- [ ] App preview video (opzionale)
- [ ] Privacy policy URL
- [ ] Support URL

#### Google Play (Android)
- [ ] Titolo (max 30 caratteri)
- [ ] Breve descrizione (max 80 caratteri)
- [ ] Descrizione completa (max 4000 caratteri)
- [ ] Categoria
- [ ] Rating contenuti
- [ ] Screenshot (telefono, tablet 7", tablet 10")
- [ ] Feature graphic (1024x500)
- [ ] Icona (512x512)
- [ ] Privacy policy URL

### Build Release

#### iOS
```bash
flutter clean
flutter pub get
flutter build ipa --release
```
- [ ] IPA generato con successo
- [ ] Upload a TestFlight
- [ ] Test interno completato
- [ ] Test esterno (beta tester) completato

#### Android
```bash
flutter clean
flutter pub get
flutter build appbundle --release
```
- [ ] AAB generato con successo
- [ ] Upload a Google Play Console
- [ ] Test interno completato
- [ ] Test aperto/chiuso completato

### Post-Release
- [ ] Monitoraggio crash (Firebase Crashlytics se integrato)
- [ ] Monitoraggio recensioni
- [ ] Piano aggiornamenti futuri
- [ ] Backup codice e asset

## NOTE IMPORTANTI

1. **Keystore Android**: Conservare in luogo sicuro. Se perso, NON si può aggiornare l'app!
2. **Certificati iOS**: Rinnovare prima della scadenza
3. **Privacy Policy**: Deve essere ospitata su un URL pubblico
4. **Screenshot**: Devono mostrare contenuto reale dell'app
5. **Descrizione**: Ottimizzata per ASO con keywords rilevanti

## TIMELINE STIMATA

- Preparazione asset: 2-3 giorni
- Testing intensivo: 3-5 giorni
- Revisione store: 1-3 giorni (iOS), 2-7 giorni (Android)
- **Totale: 1-2 settimane**
