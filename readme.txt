Aufgaben:
==========

1.)Eingabefelder erweitern
---------------------------------
Erweitere die Eingabeelemente "InputWithLabel" so, dass folgende Funktionalitäten gegeben sind:
- Der Focus muss über eine Funktion wie setInputFocus von aussen gesetzt werden könne
- Bei einem Focuswechsel muss die Farbe von TextInput sich ändern. Wenn der focus da ist, dann blau. Ansonst schwarz
- Wenn zwei Zahlen eingegeben wurden, dann muss ein signal namens "cursorPosChanged" emittiert werden und die Cursorposition wieder auf 0 gesetzt werden
- Wenn der Text durch den User (Focus) geändert wird, dann soll die Property "value" upgedatet werden und das signal changedByUser emitiert werden
- Wenn sich der Wert des Property "value" ändert und der Focus nicht gesetzt ist, dann muss textInput.text gesetzt werden
- Der Cursor sollte nicht sichtbar sein. Achtung, sobald der Focus gesetzt wird, dann wird auch der Cursor wieder sichtbar

Bonus:
- Wenn TextInput mit der Zahl, resp. dem Text "5" initialisiert wird, dann soll der automatisch auf "05" gesetzt werden
Nenne die neue Funktion zeroFill(). Sie gibt als Return den neuen String zurück. Als Parameter wird der aufzufüllende Wert übergeben


2.) Zeitanzeige (TimerRect)
----------------
- Wenn die zwei Zahlen im TextInput "Hours" eingegeben worden sind, dann soll der Fokus automatisch auf "Minutes" wechseln.
- Wenn die zwei Zahlen im TextInput "Minutes" eingegeben worden sind, dann soll der Fokus automatisch auf "Seconds" wechseln.
