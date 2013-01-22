with p_polynome; use p_polynome;
with ada.text_io; use ada.text_io;

procedure p_polynome_test is

  -- Procedure Test
  -- Sémantique : Affiche OK si le booléen b est vrai, sinon affiche PAS OK
  -- Paramètres : b : boolean (D)
  -- Précondition : /
  -- Postcondition : /
  -- Exception : /
  procedure Test(b : in boolean) is
  begin
    if b then
      Put_line("..  OK");
    else
      Put_line(".. ECHEC");
    end if;
  end Test;

  poly : polynome;
  poly1, poly2, poly3, poly4 : polynome;

  string1, string2, string3, string4 : str;
  string_temp : str;

  i, pos : integer;
begin

  ----------------------
  -- Test Lire_Entier --
  ----------------------
  Put("Lecture d'un entier");
  string_temp.valeur(1..5) := "123AB";
  string_temp.longueur := 5;
  pos := 1;

  Lire_Entier(string_temp, pos, i);
  Test(pos = 4 and i = 123);

  Put("Lecture d'un entier, cas de fin de chaine");
  string_temp.valeur(1..5) := "AB654";
  string_temp.longueur := 5;
  pos := 3;
  
  Lire_Entier(string_temp, pos, i);
  Test(pos = 6 and i = 654);

  ---------------------------
  -- Test Ecrire_Caractere --
  ---------------------------
  Put("Ecriture d'un caractere en début de chaine");
  string_temp.longueur := 0;
  Ecrire_Caractere(string_temp, 'X');
  Test(string_temp.longueur = 1 and string_temp.valeur(1) = 'X');

  Put("Ecriture d'un caractere en milieu de chaine");
  string_temp.valeur(1..5) := "ABCDE";
  string_temp.longueur := 5;
  Ecrire_Caractere(string_temp, 'F');
  Test(string_temp.longueur = 6 and string_temp.valeur(1..6) = "ABCDEF");

  -- Test de l'exception LONGUEUR_MAX
  Put("Exception lorsque la taille du tableau est insuffisante");
  begin
    string_temp.longueur := CMAX;
    Ecrire_Caractere(string_temp, 'X');
    Test(false);
  exception
    when LONGUEUR_MAX => Test(true);
  end;

  ------------------------
  -- Test Ecrire_Entier --
  ------------------------
  Put("Ecriture d'un entier en début de chaine");
  string_temp.longueur := 0;
  Ecrire_Entier(string_temp, 123);
  Test(string_temp.longueur = 3 and string_temp.valeur(1..3) = "123");

  Put("Ecriture d'un entier en milieu de chaine");
  string_temp.valeur(1..3) := "ABC";
  string_temp.longueur := 3;
  Ecrire_Entier(string_temp, 1);
  Test(string_temp.longueur = 4 and string_temp.valeur(1..4) = "ABC1");

  -- Test de l'exception LONGUEUR_MAX
  Put("Exception lorsque la taille du tableau est insuffisante");
  begin
    string_temp.longueur := CMAX - 1;
    Ecrire_Entier(string_temp, 12);
    Test(false);
  exception
    when LONGUEUR_MAX => Test(true);
  end;

  -----------------------------
  -- Test Encoder et Decoder --
  -----------------------------
  Put_line("Encodage et Decodage d'un polynome :");

  string1.valeur(1..12) := "+1+2X1+3X1Y2";
  string1.longueur := 12;
  poly1 := Encoder(string1);

  string2.valeur(1..25) := "+13+1Z3-1X1Y1Z1+4X1Y2+1X2";
  string2.longueur := 25;
  poly2 := Encoder(string2);

  string3.valeur(1..25):= "-12-1Z3+1X1Y1Z1-4X1Y2-1X2";
  string3.longueur := 25;
  poly3 := Encoder(string3);

  string4.valeur(1..16) := "+5X1+2X1Z2-4X1Y2";
  string4.longueur := 16;
  poly4 := Encoder(string4);

  Put("Test 1");
  string_temp := Decoder(poly1);
  Test(string1.longueur = string_temp.longueur and string1.valeur(1..string1.longueur) = string_temp.valeur(1..string1.longueur));

  Put("Test 2");
  string_temp := Decoder(poly2);
  Test(string2.longueur = string_temp.longueur and string2.valeur(1..string2.longueur) = string_temp.valeur(1..string2.longueur));

  Put("Test 3");
  string_temp := Decoder(poly3);
  Test(string3.longueur = string_temp.longueur and string3.valeur(1..string3.longueur) = string_temp.valeur(1..string3.longueur));

  Put("Test 4");
  string_temp := Decoder(poly4);
  Test(string4.longueur = string_temp.longueur and string4.valeur(1..string4.longueur) = string_temp.valeur(1..string4.longueur));

  ------------------
  -- Test Ajouter --
  ------------------
  Put_line("Ajout de polynomes :");

  Put("Test 1");
  string_temp := Decoder(Ajouter(poly1, poly2));
  Test(string_temp.longueur = 29 and string_temp.valeur(1..29) = "+14+1Z3+2X1-1X1Y1Z1+7X1Y2+1X2");

  Put("Test 2");
  string_temp := Decoder(Ajouter(poly2, poly3));
  Test(string_temp.longueur = 2 and string_temp.valeur(1..2) = "+1");

  Put("Test 3");
  string_temp := Decoder(Ajouter(poly1, poly4));
  Test(string_temp.longueur = 18 and string_temp.valeur(1..18) = "+1+7X1+2X1Z2-1X1Y2");

end p_polynome_test;
