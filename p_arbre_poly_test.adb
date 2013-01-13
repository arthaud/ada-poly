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
      Put_line(".. PAS OK");
    end if;
  end Test;

  n : noeud;
  arbre : arbre_poly;
  fils1 : arbre_poly;
  fils2 : arbre_poly;
  a : arbre_poly;
begin

  ------------------------
  -- Test Ap_Creer_Vide --
  ------------------------
  Put("Création d'un arbre vide");
  arbre := Ap_Creer_Vide;
  Test(Ap_Vide(arbre));

  ---------------------------
  -- Test Ap_Creer_Feuille --
  ---------------------------
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


  ----------------------------------------------
  -- Test Ap_Inserer_Fils et Ap_Inserer_Frere --
  ----------------------------------------------
  n.puiss := 0;
  n.var := ' ';
  n.const := 1;

  fils1 := Ap_Creer_Feuille(n);

  n.puiss := 1;
  n.var := ' ';
  n.const := 1;
  
  fils2 := Ap_Creer_Feuille(n);

  Ap_Inserer_Fils(arbre, fils1);
  Ap_Inserer_Frere(fils1, fils2);

  ------------------
  -- Test Ap_Pere --
  ------------------
  Put("Récupération du père");
  Test(Ap_Pere(fils1) = arbre and Ap_Pere(fils2) = arbre);

  -------------------
  -- Test Ap_Frere --
  -------------------
  Put("Récupération du frère");
  Test(Ap_Frere(fils1) = fils2);

  ------------------
  -- Test Ap_Fils --
  ------------------
  Put("Récupération du fils");
  Test(Ap_Fils(arbre) = fils1);

  ----------------------
  -- Test Ap_Afficher --
  ----------------------
  Put_line("Affichage : ");
  Ap_Afficher(arbre);

  -----------------------------
  -- Test Ap_Supprimer_Frere --
  -----------------------------
  Put("Suppression d'un frère");
  Ap_Supprimer_Frere(fils1, 1);
  Test(not(Ap_Frere_Existe(fils1)));  

  ----------------------------
  -- Test Ap_Supprimer_Fils --
  ----------------------------
  Put("Suppression d'un fils");
  Ap_Supprimer_Fils(arbre, 1);
  Test(Ap_Est_Feuille(arbre));

end p_arbre_poly_test;
