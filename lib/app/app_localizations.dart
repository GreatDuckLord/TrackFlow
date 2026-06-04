import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static const supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('de'),
    Locale('it'),
    Locale('ar'),
  ];

  static AppLocalizations of(BuildContext context) {
    final localizations = Localizations.of<AppLocalizations>(context, AppLocalizations);
    assert(localizations != null, 'No AppLocalizations found in context');
    return localizations!;
  }

  static const Map<String, Map<String, String>> _translations = {
    'en': {
      'settings': 'Settings',
      'supported_carriers': 'Supported Carriers',
      'preferences': 'Preferences',
      'notifications': 'Notifications',
      'language': 'Language',
      'appearance': 'Appearance',
      'support': 'Support',
      'help_center': 'Help Center',
      'send_feedback': 'Send Feedback',
      'about': 'About',
      'sign_out': 'Sign Out',
      'select_language': 'Select Language',
      'auto_detect_enabled': 'Auto-detect enabled',
      'push_email_alerts': 'Push & email alerts',
      'system_default': 'System default',
      'dark_mode': 'Dark',
      'light_mode': 'Light',
      'select_appearance': 'Select Appearance',
      'packages': 'Packages',
      'activity': 'Activity',
      'profile': 'Profile',
      'select_carrier': 'Select Carrier',
      'could_not_auto_detect_carrier': 'We couldn\'t auto-detect the carrier. Please select manually.',
      'track_package': 'Track Package',
      'enter_tracking_number_hint': 'Enter a tracking number...',
      'carrier_detected': 'Carrier Detected',
      'possible_carriers': 'Possible Carriers',
      'carrier_not_recognized': 'Carrier Not Recognized',
      'could_not_identify_carrier': 'We couldn\'t identify the carrier from this tracking number. You can select a carrier manually.',
      'select_carrier_manually': 'Select Carrier Manually',
      'recent': 'Recent',
      'enter_a_tracking_number': 'Enter a tracking number',
      'tracking_description': 'The carrier will be auto-detected and its tracking page will open directly inside the app.',
      'track_now': 'Track Now',
      'no_packages_tracked_yet': 'No packages tracked yet',
      'tap_scan_to_start': 'Tap the scan button to start tracking.\nThe carrier will be auto-detected from the tracking number.',
      'no_activity_yet': 'No activity yet',
      'history_will_appear_here': 'Your tracking history will appear here.',
      'tracked_via': 'Tracked via {carrier}',
      'reload': 'Reload',
      'in_app_browser_not_supported': 'In-App Browser Not Supported',
      'desktop_browser_unsupported': 'You are running on a desktop platform. The in-app web browser is only supported on mobile devices (Android/iOS).',
      'tracking_link': 'Tracking Link',
      'link_copied': 'Link copied to clipboard!',
      'copy_link': 'Copy Link',
      'total': 'Total',
      'carriers': 'Carriers',
      'tracked_shipments': 'tracked shipment(s)',
      'top': 'Top',
      'help_search_hint': 'Search help articles...',
      'help_categories': 'Categories',
      'help_tracking_issues': 'Tracking',
      'help_general_settings': 'Settings',
      'help_account': 'Account',
      'help_faq': 'Frequently Asked Questions',
      'help_no_results': 'No matching articles found.',
      'help_still_need_help': 'Still need help?',
      'help_contact_desc': 'Our support team is ready to assist you with any questions.',
      'help_contact_support': 'Contact Support',
      'feedback_description': 'We value your feedback! Let us know how we can improve TrackFlow.',
      'feedback_category': 'Category',
      'feedback_rate_experience': 'Rate your experience',
      'feedback_message': 'Your message',
      'feedback_message_hint': 'Describe your experience or suggestion...',
      'feedback_submit': 'Submit Feedback',
      'feedback_thank_you': 'Thank you!',
      'feedback_thank_you_desc': 'Your feedback has been submitted. We appreciate you helping us improve.',
      'feedback_back_to_settings': 'Back to Settings',
      'clear_all': 'Clear All',
      'clear_all_confirm': 'Are you sure you want to clear all history?',
      'cancel': 'Cancel',
      'clear': 'Clear',
      'delete_entry': 'Delete Activity',
      'delete_entry_confirm': 'Are you sure you want to delete this activity?',
      'delete': 'Delete',
      'about_description': 'TrackFlow is an industry-leading, enterprise-grade, cloud-native logistics facilitation ecosystem designed to streamline and revolutionize package lifecycle management. Leveraging synergized data telemetry and bleeding-edge tracking architectures, TrackFlow optimizes last-mile delivery visibility, maximizes supply chain efficiency, and drives digital transformation across global touchpoints. Our holistic, mobile-first ecosystem integrates seamlessly with diverse carrier frameworks to empower end-users with real-time tracking insights, actionable notifications, and robust transactional visibility. Version: Beta 1.0.0',
    },
    'es': {
      'settings': 'Ajustes',
      'supported_carriers': 'Transportistas compatibles',
      'preferences': 'Preferencias',
      'notifications': 'Notificaciones',
      'language': 'Idioma',
      'appearance': 'Apariencia',
      'support': 'Soporte',
      'help_center': 'Centro de ayuda',
      'send_feedback': 'Enviar comentarios',
      'about': 'Acerca de',
      'sign_out': 'Cerrar sesión',
      'select_language': 'Seleccionar idioma',
      'auto_detect_enabled': 'Detección automática activada',
      'push_email_alerts': 'Alertas push y por correo',
      'system_default': 'Predeterminado del sistema',
      'dark_mode': 'Oscuro',
      'light_mode': 'Claro',
      'select_appearance': 'Seleccionar apariencia',
      'packages': 'Paquetes',
      'activity': 'Actividad',
      'profile': 'Perfil',
      'select_carrier': 'Seleccionar transportista',
      'could_not_auto_detect_carrier': 'No pudimos detectar automáticamente el transportista. Por favor seleccione manualmente.',
      'track_package': 'Rastrear paquete',
      'enter_tracking_number_hint': 'Ingrese un número de seguimiento...',
      'carrier_detected': 'Transportista detectado',
      'possible_carriers': 'Transportistas posibles',
      'carrier_not_recognized': 'Transportista no reconocido',
      'could_not_identify_carrier': 'No pudimos identificar el transportista a partir de este número de seguimiento. Puede seleccionar un transportista manualmente.',
      'select_carrier_manually': 'Seleccionar transportista manualmente',
      'recent': 'Recientes',
      'enter_a_tracking_number': 'Ingrese un número de seguimiento',
      'tracking_description': 'El transportista se detectará automáticamente y su página de seguimiento se abrirá directamente dentro de la aplicación.',
      'track_now': 'Rastrear ahora',
      'no_packages_tracked_yet': 'Aún no se han rastreado paquetes',
      'tap_scan_to_start': 'Toque el botón de escaneo para comenzar a rastrear.\nEl transportista se detectará automáticamente a partir del número de seguimiento.',
      'no_activity_yet': 'Aún no hay actividad',
      'history_will_appear_here': 'Su historial de seguimiento aparecerá aquí.',
      'tracked_via': 'Rastreado a través de {carrier}',
      'reload': 'Recargar',
      'in_app_browser_not_supported': 'Navegador en la aplicación no compatible',
      'desktop_browser_unsupported': 'Está ejecutando en una plataforma de escritorio. El navegador en la aplicación solo es compatible con dispositivos móviles (Android/iOS).',
      'tracking_link': 'Enlace de seguimiento',
      'link_copied': '¡Enlace copiado al portapapeles!',
      'copy_link': 'Copiar enlace',
      'total': 'Total',
      'carriers': 'Transportistas',
      'tracked_shipments': 'envío(s) rastreado(s)',
      'top': 'Superior',
      'help_search_hint': 'Buscar artículos de ayuda...',
      'help_categories': 'Categorías',
      'help_tracking_issues': 'Rastreo',
      'help_general_settings': 'Ajustes',
      'help_account': 'Cuenta',
      'help_faq': 'Preguntas frecuentes',
      'help_no_results': 'No se encontraron artículos.',
      'help_still_need_help': '¿Aún necesitas ayuda?',
      'help_contact_desc': 'Nuestro equipo de soporte está listo para ayudarte.',
      'help_contact_support': 'Contactar soporte',
      'feedback_description': '¡Valoramos tus comentarios! Cuéntanos cómo podemos mejorar TrackFlow.',
      'feedback_category': 'Categoría',
      'feedback_rate_experience': 'Califica tu experiencia',
      'feedback_message': 'Tu mensaje',
      'feedback_message_hint': 'Describe tu experiencia o sugerencia...',
      'feedback_submit': 'Enviar comentario',
      'feedback_thank_you': '¡Gracias!',
      'feedback_thank_you_desc': 'Tus comentarios han sido enviados. Agradecemos tu ayuda para mejorar.',
      'feedback_back_to_settings': 'Volver a Ajustes',
      'clear_all': 'Borrar todo',
      'clear_all_confirm': '¿Estás seguro de que deseas borrar todo el historial?',
      'cancel': 'Cancelar',
      'clear': 'Borrar',
      'delete_entry': 'Eliminar actividad',
      'delete_entry_confirm': '¿Estás seguro de que deseas eliminar esta actividad?',
      'delete': 'Eliminar',
      'about_description': 'TrackFlow es un ecosistema de facilitación logística de vanguardia, de grado empresarial y nativo de la nube, diseñado para simplificar y revolucionar la gestión del ciclo de vida de los paquetes. Al aprovechar la telemetría de datos sinérgicos y arquitecturas de seguimiento de última generación, TrackFlow optimiza la visibilidad de la entrega de última milla, maximiza la eficiencia de la cadena de suministro y fomenta la transformación digital en los puntos de contacto globales. Nuestro ecosistema integral, prioritario para móviles, se integra a la perfección con diversas redes de transportistas para empoderar a los usuarios finales con información de seguimiento en tiempo real, notificaciones prácticas y una sólida visibilidad transaccional. Versión: Beta 1.0.0',
    },
    'fr': {
      'settings': 'Paramètres',
      'supported_carriers': 'Transporteurs pris en charge',
      'preferences': 'Préférences',
      'notifications': 'Notifications',
      'language': 'Langue',
      'appearance': 'Apparence',
      'support': 'Assistance',
      'help_center': 'Centre d’aide',
      'send_feedback': 'Envoyer des commentaires',
      'about': 'À propos',
      'sign_out': 'Déconnexion',
      'select_language': 'Sélectionner la langue',
      'auto_detect_enabled': 'Détection automatique activée',
      'push_email_alerts': 'Alertes push et e-mail',
      'system_default': 'Paramètre système',
      'dark_mode': 'Sombre',
      'light_mode': 'Clair',
      'select_appearance': 'Sélectionner l\'apparence',
      'packages': 'Colis',
      'activity': 'Activité',
      'profile': 'Profil',
      'select_carrier': 'Sélectionner un transporteur',
      'could_not_auto_detect_carrier': 'Nous n\'avons pas pu détecter automatiquement le transporteur. Veuillez sélectionner manuellement.',
      'track_package': 'Suivre le colis',
      'enter_tracking_number_hint': 'Entrez un numéro de suivi...',
      'carrier_detected': 'Transporteur détecté',
      'possible_carriers': 'Transporteurs possibles',
      'carrier_not_recognized': 'Transporteur non reconnu',
      'could_not_identify_carrier': 'Nous n\'avons pas pu identifier le transporteur à partir de ce numéro de suivi. Vous pouvez sélectionner un transporteur manuellement.',
      'select_carrier_manually': 'Sélectionner un transporteur manuellement',
      'recent': 'Récent',
      'enter_a_tracking_number': 'Entrez un numéro de suivi',
      'tracking_description': 'Le transporteur sera détecté automatiquement et sa page de suivi s\'ouvrira directement dans l\'application.',
      'track_now': 'Suivre maintenant',
      'no_packages_tracked_yet': 'Aucun colis suivi pour le moment',
      'tap_scan_to_start': 'Appuyez sur le bouton de numérisation pour commencer à suivre.\nLe transporteur sera détecté automatiquement à partir du numéro de suivi.',
      'no_activity_yet': 'Pas encore d\'activité',
      'history_will_appear_here': 'Votre historique de suivi apparaîtra ici.',
      'tracked_via': 'Suivi via {carrier}',
      'reload': 'Recharger',
      'in_app_browser_not_supported': 'Navigateur intégré non pris en charge',
      'desktop_browser_unsupported': 'Vous utilisez une plateforme de bureau. Le navigateur intégré n\'est pris en charge que sur les appareils mobiles (Android/iOS).',
      'tracking_link': 'Lien de suivi',
      'link_copied': 'Lien copié dans le presse-papiers !',
      'copy_link': 'Copier le lien',
      'total': 'Total',
      'carriers': 'Transporteurs',
      'tracked_shipments': 'envoi(s) suivi(s)',
      'top': 'Meilleur',
      'help_search_hint': 'Rechercher des articles d\'aide...',
      'help_categories': 'Catégories',
      'help_tracking_issues': 'Suivi',
      'help_general_settings': 'Paramètres',
      'help_account': 'Compte',
      'help_faq': 'Questions fréquentes',
      'help_no_results': 'Aucun article trouvé.',
      'help_still_need_help': 'Encore besoin d\'aide ?',
      'help_contact_desc': 'Notre équipe de support est prête à vous aider.',
      'help_contact_support': 'Contacter le support',
      'feedback_description': 'Vos retours comptent ! Dites-nous comment améliorer TrackFlow.',
      'feedback_category': 'Catégorie',
      'feedback_rate_experience': 'Évaluez votre expérience',
      'feedback_message': 'Votre message',
      'feedback_message_hint': 'Décrivez votre expérience ou suggestion...',
      'feedback_submit': 'Envoyer',
      'feedback_thank_you': 'Merci !',
      'feedback_thank_you_desc': 'Vos commentaires ont été envoyés. Merci de nous aider à nous améliorer.',
      'feedback_back_to_settings': 'Retour aux paramètres',
      'clear_all': 'Tout effacer',
      'clear_all_confirm': 'Êtes-vous sûr de vouloir effacer tout l\'historique ?',
      'cancel': 'Annuler',
      'clear': 'Effacer',
      'delete_entry': 'Supprimer l\'activité',
      'delete_entry_confirm': 'Êtes-vous sûr de vouloir supprimer cette activité ?',
      'delete': 'Supprimer',
      'about_description': 'TrackFlow est un écosystème de facilitation logistique de premier plan, de classe entreprise et natif du cloud, conçu pour simplifier et révolutionner la gestion du cycle de vie des colis. En s\'appuyant sur une télémétrie de données synergiques et des architectures de suivi de pointe, TrackFlow optimise la visibilité de la livraison sur le dernier kilomètre, maximise l\'efficacité de la chaîne d\'approvisionnement et stimule la transformation digitale à travers tous les points de contact mondiaux. Notre écosystème holistique et axé sur le mobile s\'intègre parfaitement aux divers réseaux de transporteurs pour offrir aux utilisateurs des informations de suivi en temps réel, des notifications pertinentes et une visibilité transactionnelle robuste. Version : Beta 1.0.0',
    },
    'de': {
      'settings': 'Einstellungen',
      'supported_carriers': 'Unterstützte Anbieter',
      'preferences': 'Einstellungen',
      'notifications': 'Benachrichtigungen',
      'language': 'Sprache',
      'appearance': 'Design',
      'support': 'Support',
      'help_center': 'Hilfe-Center',
      'send_feedback': 'Feedback senden',
      'about': 'Über',
      'sign_out': 'Abmelden',
      'select_language': 'Sprache auswählen',
      'auto_detect_enabled': 'Automatische Erkennung aktiviert',
      'push_email_alerts': 'Push- und E-Mail-Benachrichtigungen',
      'system_default': 'Systemstandard',
      'dark_mode': 'Dunkel',
      'light_mode': 'Hell',
      'select_appearance': 'Erscheinungsbild auswählen',
      'packages': 'Pakete',
      'activity': 'Aktivität',
      'profile': 'Profil',
      'select_carrier': 'Carrier auswählen',
      'could_not_auto_detect_carrier': 'Der Carrier konnte nicht automatisch erkannt werden. Bitte wählen Sie ihn manuell aus.',
      'track_package': 'Paket verfolgen',
      'enter_tracking_number_hint': 'Geben Sie eine Sendungsnummer ein...',
      'carrier_detected': 'Carrier erkannt',
      'possible_carriers': 'Mögliche Carrier',
      'carrier_not_recognized': 'Carrier nicht erkannt',
      'could_not_identify_carrier': 'Wir konnten den Carrier anhand dieser Sendungsnummer nicht identifizieren. Sie können einen Carrier manuell auswählen.',
      'select_carrier_manually': 'Carrier manuell auswählen',
      'recent': 'Kürzlich',
      'enter_a_tracking_number': 'Geben Sie eine Sendungsnummer ein',
      'tracking_description': 'Der Carrier wird automatisch erkannt und seine Tracking-Seite wird direkt in der App geöffnet.',
      'track_now': 'Jetzt verfolgen',
      'no_packages_tracked_yet': 'Noch keine Pakete verfolgt',
      'tap_scan_to_start': 'Tippen Sie auf die Scan-Schaltfläche, um mit der Verfolgung zu beginnen.\nDer Carrier wird automatisch aus der Sendungsnummer erkannt.',
      'no_activity_yet': 'Noch keine Aktivität',
      'history_will_appear_here': 'Ihr Verfolgungsverlauf wird hier angezeigt.',
      'tracked_via': 'Verfolgt über {carrier}',
      'reload': 'Neu laden',
      'in_app_browser_not_supported': 'In-App-Browser nicht unterstützt',
      'desktop_browser_unsupported': 'Sie verwenden eine Desktop-Plattform. Der In-App-Webbrowser wird nur auf mobilen Geräten (Android/iOS) unterstützt.',
      'tracking_link': 'Tracking-Link',
      'link_copied': 'Link in die Zwischenablage kopiert!',
      'copy_link': 'Link kopieren',
      'total': 'Gesamt',
      'carriers': 'Carrier',
      'tracked_shipments': 'verfolgte Sendung(en)',
      'top': 'Top',
      'help_search_hint': 'Hilfe-Artikel suchen...',
      'help_categories': 'Kategorien',
      'help_tracking_issues': 'Verfolgung',
      'help_general_settings': 'Einstellungen',
      'help_account': 'Konto',
      'help_faq': 'Häufig gestellte Fragen',
      'help_no_results': 'Keine passenden Artikel gefunden.',
      'help_still_need_help': 'Brauchen Sie noch Hilfe?',
      'help_contact_desc': 'Unser Support-Team hilft Ihnen gerne weiter.',
      'help_contact_support': 'Support kontaktieren',
      'feedback_description': 'Wir schätzen Ihr Feedback! Sagen Sie uns, wie wir TrackFlow verbessern können.',
      'feedback_category': 'Kategorie',
      'feedback_rate_experience': 'Bewerten Sie Ihre Erfahrung',
      'feedback_message': 'Ihre Nachricht',
      'feedback_message_hint': 'Beschreiben Sie Ihre Erfahrung oder Ihren Vorschlag...',
      'feedback_submit': 'Feedback senden',
      'feedback_thank_you': 'Vielen Dank!',
      'feedback_thank_you_desc': 'Ihr Feedback wurde gesendet. Wir danken Ihnen für Ihre Hilfe.',
      'feedback_back_to_settings': 'Zurück zu Einstellungen',
      'clear_all': 'Alles löschen',
      'clear_all_confirm': 'Sind Sie sicher, dass Sie den gesamten Verlauf löschen möchten?',
      'cancel': 'Abbrechen',
      'clear': 'Löschen',
      'delete_entry': 'Aktivität löschen',
      'delete_entry_confirm': 'Sind Sie sicher, dass Sie diese Aktivität löschen möchten?',
      'delete': 'Löschen',
      'about_description': 'TrackFlow ist ein führendes, Cloud-natives Logistik-Ökosystem auf Enterprise-Niveau, das zur Optimierung und Revolutionierung des Paket-Lebenszyklus-Managements entwickelt wurde. Durch die Nutzung synergetischer Datentelemetrie und modernster Tracking-Architekturen optimiert TrackFlow die Transparenz auf der letzten Meile, maximiert die Effizienz der Lieferkette und treibt die digitale Transformation an globalen Schnittstellen voran. Unser ganzheitliches, mobiles Ökosystem lässt sich nahtlos in verschiedene Anbieter-Netzwerke integrieren, um Endbenutzern Echtzeit-Tracking-Einblicke, relevante Benachrichtigungen und robuste Transaktionsdaten zu bieten. Version: Beta 1.0.0',
    },
    'it': {
      'settings': 'Impostazioni',
      'supported_carriers': 'Corrieri supportati',
      'preferences': 'Preferenze',
      'notifications': 'Notifiche',
      'language': 'Lingua',
      'appearance': 'Aspetto',
      'support': 'Supporto',
      'help_center': 'Centro assistenza',
      'send_feedback': 'Invia feedback',
      'about': 'Informazioni',
      'sign_out': 'Disconnetti',
      'select_language': 'Seleziona lingua',
      'auto_detect_enabled': 'Rilevamento automatico attivato',
      'push_email_alerts': 'Avvisi push e email',
      'system_default': 'Predefinito di sistema',
      'dark_mode': 'Scuro',
      'light_mode': 'Chiaro',
      'select_appearance': 'Seleziona aspetto',
      'packages': 'Pacchi',
      'activity': 'Attività',
      'profile': 'Profilo',
      'select_carrier': 'Seleziona corriere',
      'could_not_auto_detect_carrier': 'Non siamo riusciti a rilevare automaticamente il corriere. Seleziona manualmente.',
      'track_package': 'Traccia pacco',
      'enter_tracking_number_hint': 'Inserisci un numero di tracciamento...',
      'carrier_detected': 'Corriere rilevato',
      'possible_carriers': 'Corrieri possibili',
      'carrier_not_recognized': 'Corriere non riconosciuto',
      'could_not_identify_carrier': 'Non siamo riusciti a identificare il corriere da questo numero di tracciamento. Puoi selezionare un corriere manualmente.',
      'select_carrier_manually': 'Seleziona corriere manualmente',
      'recent': 'Recenti',
      'enter_a_tracking_number': 'Inserisci un numero di tracciamento',
      'tracking_description': 'Il corriere verrà rilevato automaticamente e la sua pagina di tracciamento si aprirà direttamente nell\'app.',
      'track_now': 'Traccia ora',
      'no_packages_tracked_yet': 'Ancora nessun pacco tracciato',
      'tap_scan_to_start': 'Tocca il pulsante di scansione per iniziare a tracciare.\nIl corriere verrà rilevato automaticamente dal numero di tracciamento.',
      'no_activity_yet': 'Ancora nessuna attività',
      'history_will_appear_here': 'La tua cronologia di tracciamento apparirà qui.',
      'tracked_via': 'Tracciato tramite {carrier}',
      'reload': 'Ricarica',
      'in_app_browser_not_supported': 'Browser in-app non supportato',
      'desktop_browser_unsupported': 'Stai eseguendo su una piattaforma desktop. Il browser in-app è supportato solo su dispositivi mobili (Android/iOS).',
      'tracking_link': 'Link di tracciamento',
      'link_copied': 'Link copiato negli appunti!',
      'copy_link': 'Copia link',
      'total': 'Totale',
      'carriers': 'Corrieri',
      'tracked_shipments': 'spedizione(e) tracciata(e)',
      'top': 'Top',
      'help_search_hint': 'Cerca articoli di aiuto...',
      'help_categories': 'Categorie',
      'help_tracking_issues': 'Tracciamento',
      'help_general_settings': 'Impostazioni',
      'help_account': 'Account',
      'help_faq': 'Domande frequenti',
      'help_no_results': 'Nessun articolo trovato.',
      'help_still_need_help': 'Hai ancora bisogno di aiuto?',
      'help_contact_desc': 'Il nostro team di supporto è pronto ad assisterti.',
      'help_contact_support': 'Contatta il supporto',
      'feedback_description': 'Il tuo feedback è importante! Dicci come migliorare TrackFlow.',
      'feedback_category': 'Categoria',
      'feedback_rate_experience': 'Valuta la tua esperienza',
      'feedback_message': 'Il tuo messaggio',
      'feedback_message_hint': 'Descrivi la tua esperienza o suggerimento...',
      'feedback_submit': 'Invia feedback',
      'feedback_thank_you': 'Grazie!',
      'feedback_thank_you_desc': 'Il tuo feedback è stato inviato. Grazie per il tuo aiuto.',
      'feedback_back_to_settings': 'Torna alle impostazioni',
      'clear_all': 'Cancella tutto',
      'clear_all_confirm': 'Sei sicuro di voler cancellare tutta la cronologia?',
      'cancel': 'Annulla',
      'clear': 'Cancella',
      'delete_entry': 'Elimina attività',
      'delete_entry_confirm': 'Sei sicuro di voler eliminare questa attività?',
      'delete': 'Elimina',
      'about_description': 'TrackFlow è un ecosistema di facilitazione logistica leader del settore, di livello aziendale e nativo del cloud, progettato per snellire e rivoluzionare la gestione del ciclo di vita dei pacchi. Sfruttando la telemetria dei dati sinergici e architetture di tracciamento all\'avanguardia, TrackFlow ottimizza la visibilità delle consegne dell\'ultimo miglio, massimizza l\'efficienza della catena di fornitura e guida la trasformazione digitale in tutti i punti di contatto globali. Il nostro ecosistema olistico, orientato ai dispositivi mobili, si integra perfettamente con diverse strutture di corrieri per offrire agli utenti finali informazioni di tracciamento in tempo reale, notifiche utili e una solida visibilità transazionale. Versione: Beta 1.0.0',
    },
    'ar': {
      'settings': 'الإعدادات',
      'supported_carriers': 'شركات النقل المدعومة',
      'preferences': 'التفضيلات',
      'notifications': 'الإشعارات',
      'language': 'اللغة',
      'appearance': 'المظهر',
      'support': 'الدعم',
      'help_center': 'مركز المساعدة',
      'send_feedback': 'إرسال ملاحظات',
      'about': 'حول',
      'sign_out': 'تسجيل الخروج',
      'select_language': 'اختر اللغة',
      'auto_detect_enabled': 'كشف تلقائي مفعل',
      'push_email_alerts': 'تنبيهات الدفع والبريد الإلكتروني',
      'system_default': 'افتراضي النظام',
      'dark_mode': 'داكن',
      'light_mode': 'فاتح',
      'select_appearance': 'اختر المظهر',
      'packages': 'الطرود',
      'activity': 'النشاط',
      'profile': 'الملف الشخصي',
      'select_carrier': 'اختر الناقل',
      'could_not_auto_detect_carrier': 'لم نتمكن من اكتشاف الناقل تلقائيًا. يرجى الاختيار يدويًا.',
      'track_package': 'تتبع الطرد',
      'enter_tracking_number_hint': 'أدخل رقم التتبع...',
      'carrier_detected': 'تم اكتشاف الناقل',
      'possible_carriers': 'الناقلين المحتملين',
      'carrier_not_recognized': 'لم يتم التعرف على الناقل',
      'could_not_identify_carrier': 'لم نتمكن من تحديد الناقل من رقم التتبع هذا. يمكنك اختيار الناقل يدويًا.',
      'select_carrier_manually': 'اختر الناقل يدويًا',
      'recent': 'الأخيرة',
      'enter_a_tracking_number': 'أدخل رقم التتبع',
      'tracking_description': 'سيتم اكتشاف الناقل تلقائيًا وسيتم فتح صفحة التتبع الخاصة به مباشرة داخل التطبيق.',
      'track_now': 'تتبع الآن',
      'no_packages_tracked_yet': 'لم يتم تتبع أي طرود بعد',
      'tap_scan_to_start': 'اضغط على زر المسح للبدء بالتتبع.\nسيتم اكتشاف الناقل تلقائيًا من رقم التتبع.',
      'no_activity_yet': 'لا توجد أي نشاطات بعد',
      'history_will_appear_here': 'سيظهر سجل التتبع هنا.',
      'tracked_via': 'تم التتبع عبر {carrier}',
      'reload': 'إعادة تحميل',
      'in_app_browser_not_supported': 'المتصفح داخل التطبيق غير مدعوم',
      'desktop_browser_unsupported': 'أنت تعمل على نظام سطح مكتب. يتم دعم المتصفح داخل التطبيق فقط على أجهزة الجوال (Android/iOS).',
      'tracking_link': 'رابط التتبع',
      'link_copied': 'تم نسخ الرابط إلى الحافظة!',
      'copy_link': 'نسخ الرابط',
      'total': 'الإجمالي',
      'carriers': 'شركات النقل',
      'tracked_shipments': 'شحنة/شحنات متتبعة',
      'top': 'الأفضل',
      'help_search_hint': 'ابحث في مقالات المساعدة...',
      'help_categories': 'الفئات',
      'help_tracking_issues': 'التتبع',
      'help_general_settings': 'الإعدادات',
      'help_account': 'الحساب',
      'help_faq': 'الأسئلة الشائعة',
      'help_no_results': 'لم يتم العثور على مقالات.',
      'help_still_need_help': 'هل ما زلت بحاجة إلى مساعدة؟',
      'help_contact_desc': 'فريق الدعم لدينا جاهز لمساعدتك.',
      'help_contact_support': 'اتصل بالدعم',
      'feedback_description': 'نقدّر ملاحظاتك! أخبرنا كيف يمكننا تحسين TrackFlow.',
      'feedback_category': 'الفئة',
      'feedback_rate_experience': 'قيّم تجربتك',
      'feedback_message': 'رسالتك',
      'feedback_message_hint': 'صف تجربتك أو اقتراحك...',
      'feedback_submit': 'إرسال الملاحظات',
      'feedback_thank_you': 'شكراً لك!',
      'feedback_thank_you_desc': 'تم إرسال ملاحظاتك. نقدّر مساعدتك في التحسين.',
      'feedback_back_to_settings': 'العودة إلى الإعدادات',
      'clear_all': 'مسح الكل',
      'clear_all_confirm': 'هل أنت متأكد من أنك تريد مسح السجل بأكمله؟',
      'cancel': 'إلغاء',
      'clear': 'مسح',
      'delete_entry': 'حذف النشاط',
      'delete_entry_confirm': 'هل أنت متأكد من أنك تريد حذف هذا النشاط؟',
      'delete': 'حذف',
      'about_description': 'إن TrackFlow هو نظام بيئي رائد في مجال الخدمات اللوجستية على مستوى المؤسسات ومصمم خصيصًا لتسهيل وتبسيط وإحداث ثورة في إدارة دورة حياة الطرود. من خلال الاستفادة من القياس عن بعد للبيانات التآزرية وهندسة التتبع المتطورة، يعمل TrackFlow على تحسين رؤية تسليم الميل الأخير، وزيادة كفاءة سلسلة التوريد، ودفع التحول الرقمي عبر نقاط الاتصال العالمية. يتكامل نظامنا البيئي الشامل الذي يركز على الهاتف المحمول بسلاسة مع هياكل شركات النقل المتنوعة لتمكين المستخدمين النهائيين من رؤى التتبع في الوقت الفعلي، والإشعارات القابلة للتنفيذ، والرؤية المعاملات القوية. الإصدار: Beta 1.0.0',
    },
  };

  String translate(String key) {
    return _translations[locale.languageCode]?[key] ??
        _translations['en']![key] ??
        key;
  }

  String get settings => translate('settings');
  String get supportedCarriers => translate('supported_carriers');
  String get preferences => translate('preferences');
  String get notifications => translate('notifications');
  String get language => translate('language');
  String get appearance => translate('appearance');
  String get support => translate('support');
  String get helpCenter => translate('help_center');
  String get sendFeedback => translate('send_feedback');
  String get about => translate('about');
  String get signOut => translate('sign_out');
  String get selectLanguage => translate('select_language');
  String get autoDetectEnabled => translate('auto_detect_enabled');
  String get pushEmailAlerts => translate('push_email_alerts');
  String get systemDefault => translate('system_default');
  String get darkMode => translate('dark_mode');
  String get lightMode => translate('light_mode');
  String get selectAppearance => translate('select_appearance');
  String get packages => translate('packages');
  String get trackedShipments => translate('tracked_shipments');
  String get activity => translate('activity');
  String get profile => translate('profile');
  String get selectCarrier => translate('select_carrier');
  String get couldNotAutoDetectCarrier => translate('could_not_auto_detect_carrier');
  String get trackPackage => translate('track_package');
  String get enterTrackingNumberHint => translate('enter_tracking_number_hint');
  String get carrierDetected => translate('carrier_detected');
  String get possibleCarriers => translate('possible_carriers');
  String get carrierNotRecognized => translate('carrier_not_recognized');
  String get couldNotIdentifyCarrier => translate('could_not_identify_carrier');
  String get selectCarrierManually => translate('select_carrier_manually');
  String get recent => translate('recent');
  String get enterATrackingNumber => translate('enter_a_tracking_number');
  String get trackingDescription => translate('tracking_description');
  String get trackNow => translate('track_now');
  String get noPackagesTrackedYet => translate('no_packages_tracked_yet');
  String get tapScanToStart => translate('tap_scan_to_start');
  String get noActivityYet => translate('no_activity_yet');
  String get historyWillAppearHere => translate('history_will_appear_here');
  String trackedVia(String carrier) => translate('tracked_via').replaceFirst('{carrier}', carrier);
  String get reload => translate('reload');
  String get inAppBrowserNotSupported => translate('in_app_browser_not_supported');
  String get desktopBrowserUnsupported => translate('desktop_browser_unsupported');
  String get trackingLink => translate('tracking_link');
  String get linkCopied => translate('link_copied');
  String get copyLink => translate('copy_link');
  String get total => translate('total');
  String get carriers => translate('carriers');
  String get top => translate('top');
  String get helpSearchHint => translate('help_search_hint');
  String get helpCategories => translate('help_categories');
  String get helpTrackingIssues => translate('help_tracking_issues');
  String get helpGeneralSettings => translate('help_general_settings');
  String get helpAccount => translate('help_account');
  String get helpFaq => translate('help_faq');
  String get helpNoResults => translate('help_no_results');
  String get helpStillNeedHelp => translate('help_still_need_help');
  String get helpContactDesc => translate('help_contact_desc');
  String get helpContactSupport => translate('help_contact_support');
  String get feedbackDescription => translate('feedback_description');
  String get feedbackCategory => translate('feedback_category');
  String get feedbackRateExperience => translate('feedback_rate_experience');
  String get feedbackMessage => translate('feedback_message');
  String get feedbackMessageHint => translate('feedback_message_hint');
  String get feedbackSubmit => translate('feedback_submit');
  String get feedbackThankYou => translate('feedback_thank_you');
  String get feedbackThankYouDesc => translate('feedback_thank_you_desc');
  String get feedbackBackToSettings => translate('feedback_back_to_settings');
  String get clearAll => translate('clear_all');
  String get clearAllConfirm => translate('clear_all_confirm');
  String get cancel => translate('cancel');
  String get clear => translate('clear');
  String get deleteEntry => translate('delete_entry');
  String get deleteEntryConfirm => translate('delete_entry_confirm');
  String get delete => translate('delete');
  String get aboutDescription => translate('about_description');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales.any(
      (supportedLocale) => supportedLocale.languageCode == locale.languageCode,
    );
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;

  static const instance = AppLocalizationsDelegate();
}
