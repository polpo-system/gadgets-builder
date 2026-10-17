MODULE BuilderTest;  (** BuilderTest.Run: the module loaded, an error marker made; needs the desktop's display *)

IMPORT Objects, Display, Gadgets, Documents, Modules, Out := out;

VAR fails, checks: LONGINT;

PROCEDURE Check(what: ARRAY OF CHAR; ok: BOOLEAN);
BEGIN
  INC(checks);
  IF ~ok THEN INC(fails); Out.String("FAIL "); Out.String(what); Out.Ln END
END Check;

PROCEDURE Frame(gen: ARRAY OF CHAR);
VAR obj: Objects.Object;
BEGIN
  obj := Gadgets.CreateObject(gen); Check(gen, (obj # NIL) & (obj IS Display.Frame))
END Frame;

PROCEDURE Obj(gen: ARRAY OF CHAR);
BEGIN
  Check(gen, Gadgets.CreateObject(gen) # NIL)
END Obj;

PROCEDURE Doc(gen, file: ARRAY OF CHAR);
VAR obj: Objects.Object; doc: Documents.Document;
BEGIN
  obj := Gadgets.CreateObject(gen);
  IF (obj # NIL) & (obj IS Documents.Document) THEN
    doc := obj(Documents.Document); IF file # "" THEN COPY(file, doc.name) END;
    doc.Load(doc); Check(gen, (doc.dsc # NIL) & (doc.dsc IS Display.Frame))
  ELSE Check(gen, FALSE)
  END
END Doc;

PROCEDURE Open(file: ARRAY OF CHAR);
VAR doc: Documents.Document;
BEGIN
  doc := Documents.Open(file); Check(file, (doc # NIL) & (doc.dsc # NIL))
END Open;

PROCEDURE Mod(name: ARRAY OF CHAR);
BEGIN
  Check(name, Modules.ThisMod(name) # NIL)
END Mod;

PROCEDURE Run*;
BEGIN
  fails := 0; checks := 0;
  Mod("Builder");
  Frame("Builder.NewErrorGadget");
  Out.String("BuilderTest: "); Out.Int(checks, 0); Out.String(" checks, "); Out.Int(fails, 0); Out.String(" failed"); Out.Ln
END Run;

END BuilderTest.
