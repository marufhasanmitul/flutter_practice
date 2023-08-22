Firebase Setup Process :

01. Flutter Website App Create
02. Android Package SetUp.
03. Android Studio App inside Google services Add.
04. Project level Bild gradle Some Package add;

    classpath 'com.google.gms:google-services:4.3.15'


    kottlin version-1.8.0

6. App level gradle some Package Add

 
   apply plugin: 'com.google.gms.google-services

   dependencies:

   
   
   implementation(platform("com.google.firebase:firebase-bom:32.2.2"))

   
   implementation("com.google.firebase:firebase-analytics-ktx")


    minSdkVersion 19
    targetSdkVersion 33

