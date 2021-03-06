with p_arbre_poly; use p_arbre_poly;
with ada.text_io; use ada.text_io;

procedure p_arbre_poly_test is

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

  n : noeud;
  b : boolean;
  arbre : arbre_poly;
  fils1, fils2, fils3, fils4 : arbre_poly;
  temp, temp2 : arbre_poly;
  a_vide : arbre_poly;
begin

  a_vide := Ap_Creer_Vide;

  -----------------------------------
  -- Test Ap_Creer_Vide et Ap_Vide --
  -----------------------------------
  Put("Création d'un arbre vide");
  Test(Ap_Vide(a_vide));

  --------------------------------------
  -- Test Ap_Creer_Feuille et Ap_Vide --
  --------------------------------------
  Put("Création d'une feuille");
  n.puiss := 0;
  n.var := 'X';
  n.const := 0;
  arbre := Ap_Creer_Feuille(n);
  Test(not(Ap_Vide(arbre)));

  --------------------
  -- Test Ap_Valeur --
  --------------------
  Put("Récupération de la valeur");
  Test(Ap_Valeur(arbre) = n);

  -- Test de l'exception ARBRE_VIDE
  Put("Exception lors de la récupération sur un arbre vide");
  begin
    n := Ap_Valeur(Ap_Creer_Vide);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;

  ----------------------------
  -- Test Ap_Changer_Valeur --
  ----------------------------
  Put("Modification d'une valeur");
  n.var := 'Y';
  Ap_Changer_Valeur(arbre, n);
  Test(Ap_Valeur(arbre) = n);

  -- Test de l'exception ARBRE_VIDE
  Put("Exception lors d'une modification sur un arbre vide");
  begin
    Ap_Changer_Valeur(a_vide, n);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;
  
  -------------------------------------
  -- Test Ap_Inserer_Fils et Ap_Pere --
  -------------------------------------
  Put("Insertion d'un fils en première position");
  n.puiss := 0;
  n.var := ' ';
  n.const := 1;

  fils1 := Ap_Creer_Feuille(n);

  Ap_Inserer_Fils(arbre, fils1);
  Test(Ap_Pere(fils1) = arbre);

  -- Test de l'exception ARBRE_VIDE
  Put("Exception lors de l'insertion d'un premier fils sur un arbre vide");
  begin
    temp := Ap_Creer_Feuille(n);
    Ap_Inserer_Fils(a_vide, temp);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;

  Put("Exception lors de l'insertion d'un premier fils d'un arbre vide");
  begin
    temp := Ap_Creer_Feuille(n);
    Ap_Inserer_Fils(temp, a_vide);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;

  --------------------------------------
  -- Test Ap_Inserer_Frere et Ap_Pere --
  --------------------------------------
  Put("Insertion d'un frère en première position");
  n.puiss := 1;
  n.var := ' ';
  n.const := 1;
  
  fils2 := Ap_Creer_Feuille(n);

  Ap_Inserer_Frere(fils1, fils2);
  Test(Ap_Pere(fils2) = arbre);

  -- Test de l'exception ARBRE_VIDE
  Put("Exception lors de l'insertion d'un premier frère sur un arbre vide");
  begin
    temp := Ap_Creer_Feuille(n);
    Ap_Inserer_Frere(a_vide, temp);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;

  Put("Exception lors de l'insertion d'un premier frère d'un arbre vide");
  begin
    temp := Ap_Creer_Feuille(n);
    Ap_Inserer_Frere(temp, a_vide);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;

  ------------------
  -- Test Ap_Pere --
  ------------------
  Put("Récupération du père");
  Test(Ap_Pere(fils1) = arbre);

  Put("Récupération du père sur une racine");
  Test(Ap_Vide(Ap_Pere(arbre)));

  -- Test de l'exception ARBRE_VIDE
  Put("Exception lors de la récupération du père sur un arbre vide");
  begin
    temp := Ap_Pere(Ap_Creer_Vide);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;

  -------------------
  -- Test Ap_Frere --
  -------------------
  Put("Récupération du frère");
  Test(Ap_Frere(fils1) = fils2);

  Put("Récupération du frère sur un arbre sans frère");
  Test(Ap_Vide(Ap_Frere(arbre)));

  -- Test de l'exception ARBRE_VIDE
  Put("Exception lors de la récupération du frère sur un arbre vide");
  begin
    temp := Ap_Frere(Ap_Creer_Vide);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;

  --------------------------
  -- Test Ap_Frere_Existe --
  --------------------------
  Put("Test si un arbre a un frère");
  Test(Ap_Frere_Existe(fils1) and not(Ap_Frere_Existe(arbre)));

  -- Test de l'exception ARBRE_VIDE
  Put("Exception lors du test sur un arbre vide");
  begin
    b := Ap_Frere_Existe(Ap_Creer_Vide);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;

  ------------------
  -- Test Ap_Fils --
  ------------------
  Put("Récupération du premier fils");
  Test(Ap_Fils(arbre) = fils1);

  Put("Récupération du fils sur un arbre sans fils");
  Test(Ap_Vide(Ap_Fils(fils1)));

  -- Test de l'exception ARBRE_VIDE
  Put("Exception lors de la récupération du fils sur un arbre vide");
  begin
    temp := Ap_Fils(Ap_Creer_Vide);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;

  ----------------------
  -- Test Ap_Afficher --
  ----------------------
  Put_line("Affichage d'un arbre :");
  Ap_Afficher(arbre);

 -------------------------
  -- Test Ap_Est_Feuille --
  -------------------------
  Put("Test si un arbre est une feuille");
  Test(Ap_Est_Feuille(fils1) and not(Ap_Est_Feuille(arbre)));

  -- Test de l'exception ARBRE_VIDE
  Put("Exception lors du test sur un arbre vide");
  begin
    b := Ap_Est_Feuille(Ap_Creer_Vide);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;

  ------------------------
  -- Test Ap_Est_Racine --
  ------------------------
  Put("Test si un arbre est une racine");
  Test(Ap_Est_Racine(arbre) and not(Ap_Est_Racine(fils1)));

  -- Test de l'exception ARBRE_VIDE
  Put("Exception lors du test sur un arbre vide");
  begin
    b := Ap_Est_Racine(Ap_Creer_Vide);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;

  ----------------------------------
  -- Test Ap_Inserer_Dernier_Fils --
  ----------------------------------
  Put("Insertion d'un fils en dernière position");
  n.puiss := 4;
  n.var := ' ';
  n.const := 10;
  fils3 := Ap_Creer_Feuille(n);
  Ap_Inserer_Dernier_Fils(arbre, fils3);
  Test(Ap_Pere(fils3) = arbre and Ap_Frere(fils2) = fils3);

  -- Test de l'exception ARBRE_VIDE
  Put("Exception lors de l'insertion d'un fils en dernière position dans un arbre vide");
  begin
    temp := Ap_Creer_Feuille(n);
    Ap_Inserer_Dernier_Fils(a_vide, temp);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;

  Put("Exception lors de l'insertion d'un fils en dernière position d'un arbre vide");
  begin
    temp := Ap_Creer_Feuille(n);
    Ap_Inserer_Dernier_Fils(temp, a_vide);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;

  -----------------------------------
  -- Test Ap_Inserer_Dernier_Frere --
  -----------------------------------
  Put("Insertion d'un frère en dernière position");
  n.puiss := 5;
  n.var := ' ';
  n.const := 7;
  fils4 := Ap_Creer_Feuille(n);
  Ap_Inserer_Dernier_Frere(fils2, fils4);
  Test(Ap_Pere(fils4) = arbre and Ap_Frere(fils3) = fils4);

   -- Test de l'exception ARBRE_VIDE
  Put("Exception lors de l'insertion d'un frère en dernière position dans un arbre vide");
  begin
    temp := Ap_Creer_Feuille(n);
    Ap_Inserer_Dernier_Frere(a_vide, temp);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;

  Put("Exception lors de l'insertion d'un frère en dernière position d'un arbre vide");
  begin
    temp := Ap_Creer_Feuille(n);
    Ap_Inserer_Dernier_Frere(temp, a_vide);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;

  --------------------
  -- Test Ap_Copier --
  --------------------
  Put("Copie d'un arbre");
  temp := Ap_Copier(arbre);
  Test(temp /= arbre and Ap_Valeur(temp).var = 'Y' and Ap_Valeur(Ap_Fils(temp)).const = 1 and Ap_Pere(Ap_Frere(Ap_Fils(temp))) = temp); 

  -------------------------------
  -- Test Ap_Copier_Sans_Frere --
  -------------------------------
  Put("Copie d'un arbre sans les frères de la racine");
  temp := Ap_Copier_Sans_Frere(Ap_Fils(arbre));
  Test(temp /= Ap_Fils(arbre) and Ap_Valeur(temp).var = ' ' and Ap_Valeur(temp).const = 1 and not(Ap_Frere_Existe(temp)));

  ----------------------------
  -- Test Ap_Supprimer_Fils --
  ----------------------------
  Put("Test suppression du premier fils");
  temp := Ap_Copier(arbre);
  Ap_Supprimer_Fils(temp, 1);
  Test(Ap_Valeur(Ap_Fils(temp)).puiss = 1 and Ap_Valeur(Ap_Frere(Ap_Fils(temp))).puiss = 4);

  Put("Test suppression d'un fils quelconque");
  temp := Ap_Copier(arbre);
  Ap_Supprimer_Fils(temp, 2);
  Test(Ap_Valeur(Ap_Fils(temp)).puiss = 0 and Ap_Valeur(Ap_Frere(Ap_Fils(temp))).puiss = 4);

  -- Test de l'exception ARBRE_VIDE
  Put("Exception lors de la suppression sur un arbre vide");
  begin
    Ap_Supprimer_Fils(a_vide, 1);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;

  -- Test de l'exception FILS_ABSENT
  Put("Exception lors de la suppression d'un fils inexistant, cas où il n'y a aucun fils");
  begin
    temp := Ap_Creer_Feuille(n);
    Ap_Supprimer_Fils(temp, 1);
    Test(false);
  exception
    when FILS_ABSENT => Test(true);
  end;

  Put("Exception lors de la suppression d'un fils inexistant, cas où il y a au moins un fils");
  begin
    temp := Ap_Copier(arbre);
    Ap_Supprimer_Fils(temp, 5);
    Test(false);
  exception
    when FILS_ABSENT => Test(true);
  end;

  -----------------------------
  -- Test Ap_Supprimer_Frere --
  -----------------------------
  Put("Suppression du premier frère");
  temp := Ap_Copier(Ap_Fils(arbre));
  Ap_Supprimer_Frere(temp, 1);
  Test(Ap_Valeur(temp).puiss = 0 and Ap_Valeur(Ap_Frere(temp)).puiss = 4);

  Put("Suppression d'un frère quelconque");
  temp := Ap_Copier(Ap_Fils(arbre));
  Ap_Supprimer_Frere(temp, 2);
  Test(Ap_Valeur(temp).puiss = 0 and Ap_Valeur(Ap_Frere(temp)).puiss = 1 and Ap_Valeur(Ap_Frere(Ap_Frere(temp))).puiss = 5);

  -- Test de l'exception ARBRE_VIDE
  Put("Exception lors de la suppression sur un arbre vide");
  begin
    Ap_Supprimer_Frere(a_vide, 1);
    Test(false);
  exception
    when ARBRE_VIDE => Test(true);
  end;

  -- Test de l'exception FILS_ABSENT
  Put("Exception lors de la suppression d'un frère inexistant");
  begin
    temp := Ap_Copier(Ap_Fils(arbre));
    Ap_Supprimer_Frere(temp, 5);
    Test(false);
  exception
    when FRERE_ABSENT => Test(true);
  end;

end p_arbre_poly_test;
