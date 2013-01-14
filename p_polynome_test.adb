with p_polynome; use p_polynome;
with p_arbre_poly; use p_arbre_poly;
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
      Put_line(".. PAS OK");
    end if;
  end Test;

  n : noeud;
  poly1 : arbre_poly;
  poly2 : arbre_poly;
  poly3 : arbre_poly;
  poly4 : arbre_poly;
  poly5 : arbre_poly;
  temp : arbre_poly;
  temp2 : arbre_poly;
  fils : arbre_poly;

  aff : str;
begin

  -- Arbre Poly 1 --
  n.puiss := 0;
  n.var := 'X';
  n.const := 0;

  poly1 := Ap_Creer_Feuille(n);

  n.puiss := 1;
  n.var := ' ';
  n.const := 4;
  temp := Ap_Creer_Feuille(n);
  Ap_Inserer_Fils(poly1, temp);

  n.puiss := 0;
  n.var := 'Z';
  n.const := 0;
  fils := Ap_Creer_Feuille(n);
  Ap_Inserer_Fils(poly1, fils);

  n.puiss := 3;
  n.var := ' ';
  n.const := 1;
  temp := Ap_Creer_Feuille(n);
  Ap_Inserer_Fils(fils, temp);

  n.puiss := 0;
  n.var := ' ';
  n.const := 13;
  temp := Ap_Creer_Feuille(n);
  Ap_Inserer_Fils(fils, temp);

  Put_line("Polynome 1 :");
  Ap_Afficher(poly1);
  new_line;

  -- Arbre Poly 2 --
  n.puiss := 0;
  n.var := 'X';
  n.const := 0;

  poly2 := Ap_Creer_Feuille(n);

  n.puiss := 1;
  n.var := 'Z';
  n.const := 0;

  fils := Ap_Creer_Feuille(n);
  Ap_Inserer_Fils(poly2, fils);

  n.puiss := 1;
  n.var := ' ';
  n.const := 2;
  
  temp := Ap_Creer_Feuille(n);
  Ap_Inserer_Fils(fils, temp);

  n.puiss := 0;
  n.var := ' ';
  n.const := -3;

  temp := Ap_Creer_Feuille(n);
  Ap_Inserer_Fils(poly2, temp);

  Put_line("Polynome 2:");
  Ap_Afficher(poly2);
  new_line;

  -- Arbre Poly 3 --
  n.puiss := 0;
  n.var := 'Z';
  n.const := 0;

  poly3 := Ap_Creer_Feuille(n);

  n.puiss := 3;
  n.var := ' ';
  n.const := -1;

  fils := Ap_Creer_Feuille(n);
  Ap_Inserer_Fils(poly3, fils);

  Put_line("Polynome 3:");
  Ap_Afficher(poly3);
  new_line;

  -- Arbre Poly 4 --
  n.puiss := 0;
  n.var := 'X';
  n.const := 0;

  poly4 := Ap_Creer_Feuille(n);

  n.puiss := 1;
  n.var := 'Z';
  n.const := 0;

  fils := Ap_Creer_Feuille(n);
  Ap_Inserer_Fils(poly4, fils);

  n.puiss := 1;
  n.var := ' ';
  n.const := -2;
  
  temp := Ap_Creer_Feuille(n);
  Ap_Inserer_Fils(fils, temp);

  n.puiss := 0;
  n.var := ' ';
  n.const := 3;

  temp := Ap_Creer_Feuille(n);
  Ap_Inserer_Fils(poly4, temp);

  Put_line("Polynome 4:");
  Ap_Afficher(poly4);
  new_line;

  -- Arbre Poly 5 --
  n.puiss := 0;
  n.var := 'X';
  n.const := 0;

  poly5 := Ap_Creer_Feuille(n);

  n.puiss := 2;
  n.var := ' ';
  n.const := 1;

  fils := Ap_Creer_Feuille(n);
  Ap_Inserer_Fils(poly5, fils);

  n.puiss := 1;
  n.var := 'Y';
  n.const := 0;
  fils := Ap_Creer_Feuille(n);
  Ap_Inserer_Fils(poly5, fils);

  n.puiss := 2;
  n.var := ' ';
  n.const := 4;
  
  temp := Ap_Creer_Feuille(n);
  Ap_Inserer_Fils(fils, temp);
  
  n.puiss := 1;
  n.var := 'Z';
  n.const := 0;

  temp := Ap_Creer_Feuille(n);
  Ap_Inserer_Fils(fils, temp);

  n.puiss := 1;
  n.var := ' ';
  n.const := -1;

  temp2 := Ap_Creer_Feuille(n);
  Ap_Inserer_Fils(temp, temp2);

  n.puiss := 0;
  n.var := 'Z';
  n.const := 0;

  fils := Ap_Creer_Feuille(n);
  Ap_Inserer_Fils(poly5, fils);

  n.puiss := 3;
  n.var := ' ';
  n.const := 1;

  temp := Ap_Creer_Feuille(n);
  Ap_Inserer_Fils(fils, temp);

  n.puiss := 0;
  n.var := ' ';
  n.const := 13;

  temp := Ap_Creer_Feuille(n);
  Ap_Inserer_Fils(fils, temp);

  Put_line("Polynome 5:");
  Ap_Afficher(poly5);
  new_line;

  -- Somme --
  Put_line("Somme 1 + 4:");
  Ap_Afficher(Ajouter(poly1, poly4));
  new_line;

  -- Decodage --
  aff := Decoder(poly5);
  Put_line("Decodage 5:");
  Put_line(aff.valeur(1..aff.longueur));
end p_polynome_test;
