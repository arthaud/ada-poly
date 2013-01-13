with p_arbre_poly; use p_arbre_poly;

------------------------
-- Paquetage polynôme
------------------------
package body p_polynome is

  -- Fonction Encoder
  -- Sémantique : Prend un polynôme sous forme de chaine de caractères, et retourne un polynôme
  -- Paramètres : p : string (D)
  -- Précondition : p vérifie les contraintes du sujet
  -- Postcondition : le polynôme retourné est p
  -- function Encoder(p : in string) return polynome;

  -- Fonction Decoder
  -- Sémantique : Prend un polynôme et retourne la chaine de caractères correspondante
  -- Paramètres : p : polynome (D)
  -- Précondition : /
  -- Postcondition : le polynôme retourné est p
  -- function Decoder(p : in polynome) return string;


  -- Fonction Ajouter_Constante
  -- Sémantique : Fait l'addition de deux polynomes
  -- Paramètres : p1 : polynome (D)
  --              p2 : polynome (D)
  -- Type retour : polynome
  -- Précondition : 
  --   not(Ap_Vide(p1)) et not(Ap_Vide(p2))
  --   Ap_Valeur(p1).const /= 0
  --   Ap_Valeur(p2).const /= 0
  --   Ap_Valeur(p1).puiss = Ap_Valeur(p2).puiss
  -- Postcondition : la sortie vaut p1 + p2
  function Ajouter_Constante(p1 : in polynome; p2 : in polynome) return polynome is
    n : noeud;
  begin
    n.puiss := Ap_Valeur(p1).puiss;
    n.var := ' ';
    n.const := Ap_Valeur(p1).const + Ap_Valeur(p2).const;

    if n.const = 0 then -- somme nulle
      return Ap_Creer_Vide;
    else
      return Ap_Creer_Feuille(n);
    end if;
  end Ajouter_Constante;


  -- Fonction Ajouter_Puissance0
  -- Sémantique : Ajouter l'arbre p2 dans le fils de puissance 0 de p1
  -- Paramètres : p1 : polynome (D)
  --              p2 : polynome (D)
  -- Type retour : polynome
  -- Précondition :
  --   not(Ap_Vide(p1)) et not(Ap_Vide(p2))
  --   Ap_Valeur(p1).const = 0 donc p1 a au moins un fils
  --   Ap_Valeur(p1).puiss = Ap_Valeur(p2).puiss
  -- Postcondition : la sortie vaut p1 + p2
  function Ajouter_Puissance0(p1 : in polynome; p2 : in polynome) return polynome is
    n : noeud;
    copie_p2 : polynome;
    somme : polynome;
    resultat : polynome;
    autre_fils : polynome;
  begin
    -- Copie de p2, en mettant la puissance 0 à la racine
    copie_p2 := Ap_Copier_Sans_Frere(p2);
    n := Ap_Valeur(p2);
    n.puiss := 0;
    Ap_Changer_Valeur(copie_p2, n);

    if Ap_Valeur(Ap_Fils(p1)).puiss = 0 then -- p1 a un fils de puissance 0
      
      -- Ajouter la copie de p2 avec ce fils
      somme := Ajouter(Ap_Fils(p1), copie_p2);

      if Ap_Vide(somme) and not(Ap_Frere_Existe(Ap_Fils(p1))) then -- resultat nulle, et pas d'autre fils
        return Ap_Creer_Vide;
      else
        resultat := Ap_Copier_Sans_Frere(p1);
        Ap_Supprimer_Fils(resultat, 1);
        Ap_Inserer_Fils(resultat, somme);

        return resultat;
      end if;
    else -- p1 n'a pas de fils de puissance 0
      resultat := Ap_Copier_Sans_Frere(p1);
      Ap_Inserer_Fils(resultat, copie_p2);

      return resultat;
    end if;
  end Ajouter_Puissance0;

  -- Fonction Ajouter_Variable_Identique
  -- Sémantique : Fait l'addition de deux polynômes
  -- Paramètres : p1 : polynome (D)
  --              p2 : polynome (D)
  -- Type retour : polynome
  -- Précondition :
  --   not(Ap_Vide(p1)) et not(Ap_Vide(p2))
  --   Ap_Valeur(p1).const = Ap_Valeur(p2).const = 0
  --   Ap_Valeur(p1).var = Ap_Valeur(p2).var
  --   Ap_Valeur(p1).puiss = Ap_Valeur(p2).puiss
  -- Postcondition : la sortie vaut p1 + p2
  function Ajouter_Variable_Identique(p1 : in polynome; p2 : in polynome) return polynome is
    resultat : polynome;
    sp1 : polynome;
    sp2 : polynome;
    somme : polynome;
    copie : polynome;
  begin
    -- copie de la racine
    resultat := Ap_Creer_Feuille(Ap_Valeur(p1));
    
    -- Parcours des fils
    sp1 := Ap_Fils(p1);
    sp2 := Ap_Fils(p2);

    loop
      if Ap_Valeur(sp1).puiss = Ap_Valeur(sp2).puiss then -- sp1 et sp2 ont la même puissance
        somme := Ajouter(sp1, sp2);

        if not(Ap_Vide(somme)) then -- si la somme n'est pas nulle
          Ap_Inserer_Dernier_Fils(resultat, somme);
        end if;

        if Ap_Frere_Existe(sp1) then -- si sp1 a un frère
          sp1 := Ap_Frere(sp1);
        else
          sp1 := Ap_Creer_Vide;
        end if;

        if Ap_Frere_Existe(sp2) then -- si sp2 a un frère
          sp2 := Ap_Frere(sp2);
        else
          sp2 := Ap_Creer_Vide;
        end if;

      elsif Ap_Valeur(sp1).puiss < Ap_Valeur(sp2).puiss then -- puissance de sp1 plus petite que sp2
        copie := Ap_Copier_Sans_Frere(sp1);
        Ap_Inserer_Dernier_Fils(resultat, copie);

        if Ap_Frere_Existe(sp1) then -- si sp1 a un frère
          sp1 := Ap_Frere(sp1);
        else
          sp1 := Ap_Creer_Vide;
        end if;
      else -- puissance de sp1 plus grande que sp2
        copie := Ap_Copier_Sans_Frere(sp2);
        Ap_Inserer_Dernier_Fils(resultat, copie);

        if Ap_Frere_Existe(sp2) then -- si sp2 a un frère
          sp2 := Ap_Frere(sp2);
        else
          sp2 := Ap_Creer_Vide;
        end if;
      end if;

      exit when Ap_Vide(sp1) or Ap_Vide(sp2);
    end loop;

    -- on met dans sp1 les fils non vides
    if Ap_Vide(sp1) then
      sp1 := sp2;
    end if;
    
    -- si sp1 n'est pas vide, on ajoute ces fils au résultat
    while not(Ap_Vide(sp1)) loop
      copie := Ap_Copier_Sans_Frere(sp1);
      Ap_Inserer_Dernier_Fils(resultat, copie);

      if Ap_Frere_Existe(sp1) then
        sp1 := Ap_Frere(sp1);
      else
        sp1 := Ap_Creer_Vide;
      end if;
    end loop;

    if Ap_Est_Feuille(resultat) then -- aucun fils
      return Ap_Creer_Vide;
    else
      return resultat;
    end if;
  end Ajouter_Variable_Identique;

  -- Fonction Ajouter
  -- Sémantique : Fait l'addition de deux polynomes
  -- Paramètres : p1 : polynome (D)
  --              p2 : polynome (D)
  -- Précondition : /
  -- Postcondition : la sortie vaut p1 + p2
  function Ajouter(p1 : in polynome; p2 : in polynome) return polynome is
  begin
    if Ap_Vide(p1) and Ap_Vide(p1) then -- p1 et p2 sont vides
      return Ap_Creer_Vide;
    elsif Ap_Vide(p1) then -- p1 est vide
      return Ap_Copier_Sans_Frere(p2);
    elsif Ap_Vide(p2) then -- p2 est vide
      return Ap_Copier_Sans_Frere(p1);
    else -- p1 et p2 ne sont pas vides
      if Ap_Valeur(p1).const /= 0 and Ap_Valeur(p2).const /= 0 then -- p1 et p2 sont des constantes
        return Ajouter_Constante(p1, p2);
      elsif Ap_Valeur(p1).const /= 0 then -- p1 est une constante
        return Ajouter_Puissance0(p2, p1);
      elsif Ap_Valeur(p2).const /= 0 then -- p2 est une constante
        return Ajouter_Puissance0(p1, p2);
      else -- p1 et p2 ne sont pas des constantes
        if Character'Pos(Ap_Valeur(p1).var) = Character'Pos(Ap_Valeur(p2).var) then -- même variable
          return Ajouter_Variable_Identique(p1, p2);
        elsif Character'Pos(Ap_Valeur(p1).var) > Character'Pos(Ap_Valeur(p2).var) then -- p1 a la variable la plus grande (ordre alphabétique) à la racine
          return Ajouter_Puissance0(p2, p1);
        else -- sinon c'est p2 
          return Ajouter_Puissance0(p1, p2);
        end if;
      end if;
    end if;
  end Ajouter;
 
end p_polynome;
