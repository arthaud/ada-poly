with p_arbren; use p_arbren;
with ada.text_io; use ada.text_io;

procedure p_arbren_test is

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
      Put_line("..  PAS OK");
    end if;
  end Test;

  -- Fonction Arbre_Test
  -- Sémantique : Créé un arbre de test
  -- Paramètres : /
  -- Précondition : /
  -- Postcondition : /
  -- Exception : /
  function Arbre_Test return arbren is
    arbre : arbren;
    fils1, fils2, fils2_1, fils3 : arbren;
  begin
    arbre := An_Creer_Feuille('a');
    fils1 := An_Creer_Feuille('b');
    fils2 := An_Creer_Feuille('c');
    fils3 := An_Creer_Feuille('d');
    fils2_1 := An_Creer_Feuille('e');

    An_Inserer_Fils(fils2, fils2_1);

    An_Inserer_Fils(arbre, fils3);
    An_Inserer_Fils(arbre, fils2);
    An_Inserer_Fils(arbre, fils1);
    return arbre;
  end Arbre_Test;

  arbre1, arbre2, arbre3 : arbren;
  a_vide : arbren;
  v : character;
  b : boolean;
begin

  a_vide := An_Creer_Vide;

  -----------------------------------
  -- Test An_Creer_Vide et An_Vide --
  -----------------------------------
  Put("Création d'un arbre vide");
  Test(An_Vide(An_Creer_Vide));

  --------------------------------------
  -- Test An_Creer_Feuille et An_Vide --
  --------------------------------------
  Put("Création d'une feuille");
  Test(not(An_Vide(An_Creer_Feuille('a'))));

  --------------------
  -- Test An_Valeur --
  --------------------
  Put("Récupération de la valeur");
  Test(An_Valeur(An_Creer_Feuille('a')) = 'a');

  -- Test de l'exception ARBRE_VIDE
  Put("Exception lors de la récupération sur un arbre vide");
  begin
    v := An_Valeur(An_Creer_Vide);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;

  ------------------
  -- Test An_Pere --
  ------------------
  Put("Exception lors de la récupération du père sur un arbre vide");
  begin
    arbre1 := An_Pere(An_Creer_Vide);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;

  -- Test de l'exception PERE_ABSENT
  Put("Exception lors de la récupération du père sur une racine");
  begin
    arbre1 := An_Pere(An_Creer_Feuille('a'));
    Test(false);
  exception
    when PERE_ABSENT => Test(true);
  end;

  ----------------------------
  -- Test An_Changer_Valeur --
  ----------------------------
  Put("Modification d'une valeur");
  arbre1 := An_Creer_Feuille('a');
  An_Changer_Valeur(arbre1, 'b');
  Test(An_Valeur(arbre1) = 'b');

  -- Test de l'exception ARBRE_VIDE
  Put("Exception lors d'une modification sur un arbre vide");
  begin
    v := An_Valeur(An_Creer_Vide);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;

  -------------------------------------
  -- Test An_Inserer_Fils et An_Pere --
  -------------------------------------
  Put("Insertion d'un fils");
  arbre1 := An_Creer_Feuille('a');
  arbre2 := An_Creer_Feuille('b');
  arbre3 := An_Creer_Feuille('c');
  An_Inserer_Fils(arbre1, arbre2);
  An_Inserer_Fils(arbre1, arbre3);

  Test(An_Pere(arbre2) = arbre1 and An_Pere(arbre3) = arbre1);

  -- Test de l'exception ARBRE_VIDE
  Put("Exception lors d'une insertion sur un arbre vide");
  begin
    An_Inserer_Fils(a_vide, arbre1);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;

  Put("Exception lors d'une insertion d'un arbre vide");
  begin
    An_Inserer_Fils(arbre1, a_vide);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;

  ---------------------------
  -- Test An_Inserer_Frere --
  ---------------------------
  Put("Insertion d'un frère");
  arbre1 := An_Creer_Feuille('a');
  arbre2 := An_Creer_Feuille('b');
  arbre3 := An_Creer_Feuille('c');

  An_Inserer_Fils(arbre1, arbre2);
  An_Inserer_Frere(arbre2, arbre3);

  Test(An_Pere(arbre2) = arbre1 and An_Pere(arbre3) = arbre1);

  -- Test de l'exception ARBRE_VIDE
  Put("Exception lors de l'insertion sur un arbre vide");
  begin
    arbre1 := An_Creer_Feuille('a');
    An_Inserer_Frere(a_vide, arbre1);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;

  Put("Exception lors d'une insertion d'un arbre vide");
  begin
    arbre1 := An_Creer_Feuille('a');
    An_Inserer_Frere(arbre1, a_vide);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;

  ----------------------
  -- Test An_Afficher --
  ----------------------
  Put_line("Affichage d'un arbre :");
  arbre1 := An_Creer_Feuille('a');
  arbre2 := An_Creer_Feuille('b');
  arbre3 := An_Creer_Feuille('c');
  An_Inserer_Fils(arbre1, arbre2);
  An_Inserer_Fils(arbre1, arbre3);

  An_Afficher(arbre1);

  Put_line("Affichage d'un arbre :");
  An_Afficher(Arbre_Test);

  -- Test de l'exception ARBRE_VIDE
  Put("Exception lors de l'affichage d'un arbre vide");
  begin
    An_Afficher(An_Creer_Vide);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;

  ------------------------
  -- Test An_Rechercher --
  ------------------------
  Put("Recherche dans un frère");
  Test(An_Rechercher(Arbre_Test, 'd') /= An_Creer_Vide and then An_Valeur(An_Rechercher(Arbre_Test, 'd')) = 'd');

  Put("Recherche dans un fils");
  Test(An_Rechercher(Arbre_Test, 'e') /= An_Creer_Vide and then An_Valeur(An_Rechercher(Arbre_Test, 'e')) = 'e');

  Put("Recherche infructueuse");
  Test(An_Rechercher(Arbre_Test, 'z') = An_Creer_Vide);

  -------------------------	
  -- Test An_Est_Feuille --
  -------------------------
  Put("Test si un arbre est une feuille");
  Test(An_Est_Feuille(An_Rechercher(Arbre_Test, 'b')) and An_Est_Feuille(An_Rechercher(Arbre_Test, 'd')) and not(An_Est_Feuille(Arbre_Test)));

  -- Test de l'exception ARBRE_VIDE
  Put("Exception lors du test sur un arbre vide");
  begin
    b := An_Est_Feuille(An_Creer_Vide);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;

  ------------------------
  -- Test An_Est_Racine --
  ------------------------
  Put("Test si un arbre est racine");
  Test(An_Est_Racine(Arbre_Test) and not(An_Est_Racine(An_Rechercher(Arbre_Test, 'b'))) and not(An_Est_Racine(An_Rechercher(Arbre_Test, 'd'))));

  -- Test de l'exception ARBRE_VIDE
  Put("Exception lors du test sur un arbre vide");
  begin
    b := An_Est_Racine(An_Creer_Vide);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;

  ----------------------------	
  -- Test An_Supprimer_Fils --
  ----------------------------
  Put("Test suppression du premier fils");
  arbre1 := Arbre_Test;
  An_Supprimer_Fils(arbre1, 1);
  Test(An_Rechercher(arbre1, 'b') = An_Creer_Vide and An_Rechercher(arbre1, 'c') /= An_Creer_Vide and An_Rechercher(arbre1, 'd') /= An_Creer_Vide);

  Put("Test suppression d'un fils quelconque");
  arbre1 := Arbre_Test;
  An_Supprimer_Fils(arbre1, 2);
  Test(An_Rechercher(arbre1, 'b') /= An_Creer_Vide and An_Rechercher(arbre1, 'c') = An_Creer_Vide and An_Rechercher(arbre1, 'd') /= An_Creer_Vide);

  -- Test de l'exception ARBRE_VIDE
  Put("Exception lors de la suppression sur un arbre vide");
  begin
    An_Supprimer_Fils(a_vide, 1);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;

  -- Test de l'exception FILS_ABSENT
  Put("Exception lors de la suppression d'un fils inexistant, cas où il n'y a aucun fils");
  begin
    arbre1 := An_Creer_Feuille('a');
    An_Supprimer_Fils(arbre1, 1);
    Test(false);
  exception
    when FILS_ABSENT => Test(true);
  end;

  Put("Exception lors de la suppression d'un fils inexistant, cas où il y a au moins un fils");
  begin
    arbre1 := Arbre_Test;
    An_Supprimer_Fils(arbre1, 4);
    Test(false);
  exception
    when FILS_ABSENT => Test(true);
  end;

  -----------------------------
  -- Test An_Supprimer_Frere --
  -----------------------------
  Put("Suppression du premier frère");
  arbre1 := An_Rechercher(Arbre_Test, 'b');
  An_Supprimer_Frere(arbre1, 1);
  Test(An_Rechercher(arbre1, 'c') = An_Creer_Vide and An_Rechercher(arbre1, 'd') /= An_Creer_Vide);

  Put("Suppression d'un frère quelconque");
  arbre1 := An_Rechercher(Arbre_Test, 'b');
  An_Supprimer_Frere(arbre1, 2);
  Test(An_Rechercher(arbre1, 'c') /= An_Creer_Vide and An_Rechercher(arbre1, 'd') = An_Creer_Vide);

  -- Test de l'exception ARBRE_VIDE
  Put("Exception lors de la suppression sur un arbre vide");
  begin
    An_Supprimer_Frere(a_vide, 1);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;

  -- Test de l'exception FRERE_ABSENT
  Put("Exception lors de la suppression d'un frère inexistant");
  begin
    arbre1 := An_Rechercher(Arbre_Test, 'b');
    An_Supprimer_Frere(arbre1, 3);
    Test(false);
  exception
    when FRERE_ABSENT => Test(true);
  end;

end p_arbren_test;
