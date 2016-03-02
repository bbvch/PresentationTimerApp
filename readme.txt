Aufgaben:
==========

1.)Eingabefelder mit Überschrift
---------------------------------
Entwickle ein Eingabefelder mit Überschrift aus "Textinput" und "Label".
Label ist Bestandteil QtQuick.Controls 1.4
Nenne das neue Element InputWithLabel.qml
Zum Testen kann das Element ins backgroundRect eingefügt werden.
Das neue Element soll folgende Properties besitzen:
- title         (Zum setzen des Labeltextes)
- validator     (für die Eingabe der Zahlewerte 0-59 oder 0-99)
- value         (Integerwert des dargestellten Textes)

Das Eingabefeld soll nur Zahlen zulassen.

2.) Zeitanzeige
----------------
Entwickle eine Zeitanzeige aus dem neu etwickeltem Element InputWithLabel und dem Rectangle "backgroundRect".
Die Anzeige sollte wie folgt aussehen:

Hours       Minutes      Seconds
 00           00           00

Nenne das neue Element "TimerRect"
