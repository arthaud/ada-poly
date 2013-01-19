with p_arbre_poly; use p_arbre_poly;

------------------------
-- Paquetage polynôme
------------------------
package body p_polynome is

  -- Procedure Lire_Entier
  -- Sémantique : Lire un entier à partir de la position pos
  -- Paramètres : p : str (D)
  --              pos : integer (D/R)
  --              entier : integer (R)
  -- Précondition : /
  -- Postcondition : /
  procedure Lire_Entier(p : in str; pos : in out integer; entier : out integer) is
  begin
    entier := 0;

    while pos <= p.longueur and then (Character'Pos(p.valeur(pos)) >= Character'Pos('0') and Character'Pos(p.valeur(pos)) <= Character'Pos('9')) loop
      entier := entier * 10 + (Character'Pos(p.valeur(pos)) - Character'Pos('0'));
      pos := pos + 1;
    end loop;
    -- pos > p.longueur or Character'Pos(p.valeur(pos)) < Character'Pos('0') or Character'Pos(p.valeur(pos)) > Character'Pos('9')
  end Lire_Entier;

  -- Procedure Lire_Monome
  -- Sémantique : Lire un monome, et l'ajouter au résultat
  -- Paramètres : p : str (D)
  --              pos : integer (D/R)
  --              resultat : polynome (D/R)
  -- Précondition : pos <= p.longueur
  -- Postcondition : /
  procedure Lire_Monome(p : in str; pos : in out integer; resultat : in out polynome) is

    -- Procedure Ajouter_Fils
    -- Sémantique : 
    --   Si l'arbre est vide, crée une feuille de noeud n
    --   Sinon, crée un fils de valeur n, et pointe dessus
    -- Paramètres : monome : polynome (D/R)
    --              n : noeud (D)
    -- Précondition : monome est vide ou n'a pas de fils
    -- Postcondition : Ap_Valeur(monome) = n
    procedure Ajouter_Fils(monome : in out polynome; n : in noeud) is
      nouveau_fils : polynome;
    begin
      if Ap_Vide(monome) then
        monome := Ap_Creer_Feuille(n);
      else
        nouveau_fils := Ap_Creer_Feuille(n);
        Ap_Inserer_Fils(monome, nouveau_fils);
        monome := nouveau_fils;
      end if;
    end Ajouter_Fils;

    positif : boolean;
    constante, puissance, puissance_precedente : integer;
    variable : character;
    monome, nouveau_fils : polynome;
    n : noeud;
  begin
    -- Lecture du signe
    positif := p.valeur(pos) = '+';
    pos := pos + 1;

    -- Lecture de la constante
    Lire_Entier(p, pos, constante);

    -- Initialisation
    monome := Ap_Creer_Vide;
    puissance_precedente := 0;

    -- Lecture des variables
    while pos <= p.longueur and then (p.valeur(pos) /= '+' and p.valeur(pos) /= '-') loop
      -- Lire la variable
      variable := p.valeur(pos);
      pos := pos + 1;

      -- Lire la puissance
      Lire_Entier(p, pos, puissance);

      n.puiss := puissance_precedente;
      n.var := variable;
      n.const := 0;
      Ajouter_Fils(monome, n);

      -- Modification de puissance_precedente
      puissance_precedente := puissance;
    end loop;
    -- pos > p.longueur or p.valeur(pos) = '+' or p.valeur(pos) = '-'

    -- Ajout de la constante
    n.puiss := puissance_precedente;
    n.var := ' ';
    if positif then
      n.const := constante;
    else
      n.const := - constante;
    end if;
    Ajouter_Fils(monome, n);    

    -- Recuperation de la racine
    while not(Ap_Est_Racine(monome)) loop
      monome := Ap_Pere(monome);
    end loop;
    -- Ap_Est_Racine(monome)

    -- Ajout du monome au résultat
    resultat := Ajouter(resultat, monome);
  end Lire_Monome;

  -- Fonction Encoder
  -- Sémantique : Prend un polynôme sous forme de chaine de caractères, et retourne un polynôme
  -- Paramètres : p : str (D)
  -- Type retour : polynome
  -- Précondition : p vérifie les contraintes du sujet
  -- Postcondition : le polynôme retourné est p
  function Encoder(p : in str) return polynome is
    pos : integer;
    resultat : polynome;
  begin
    -- Initialisation
    pos := 1;
    resultat := Ap_Creer_Vide;

    while pos <= p.longueur loop
      -- Lire un monome
      Lire_Monome(p, pos, resultat);
    end loop;
    -- pos > p.longueur

    return resultat;
  end Encoder;

  -- procedure Ecrire_Caractere
  -- Sémantique : Ecrit un caractère dans le résultat
  -- Paramètres : resultat : str (D/R)
  --              c : character (D)
  -- Précondition : /
  -- Postcondition : /
  -- Exception : LONGUEUR_MAX
  procedure Ecrire_Caractere(resultat : in out str; c : in character) is
  begin
    if resultat.longueur = CMAX then
      raise LONGUEUR_MAX;
    else
      resultat.longueur := resultat.longueur + 1;
      resultat.valeur(resultat.longueur) := c;
    end if;
  end Ecrire_Caractere;

  -- procedure Ecrire_Entier
  -- Sémantique : Ecrit un entier dans le résultat
  -- Paramètres : resultat : str (D/R)
  --              n : integer (D)
  -- Précondition : n >= 0
  -- Postcondition : /
  -- Exception : LONGUEUR_MAX
  procedure Ecrire_Entier(resultat : in out str; n : in integer) is
    p : integer := n;
    t : integer;
  begin
    t := Integer'Image(n)'Length - 1;

    if resultat.longueur + t > CMAX then
      raise LONGUEUR_MAX;
    else
      resultat.valeur((resultat.longueur + 1)..(resultat.longueur + t)) := Integer'Image(n)(2..(t+1));
      resultat.longueur := resultat.longueur + t;
    end if;
  end Ecrire_Entier;

  -- procedure Ecrire_Monome_Pere
  -- Sémantique : Ecrit les variables du monome dans le resultat
  -- Paramètres : p : polynome (D)
  --              resultat : str (D/R)
  --              puissance : integer (D)
  --              fin_constante : integer (D)
  -- Précondition :
  --   Ap_Valeur(p).const = 0
  --   fin_constante est la position du dernier caractère de la constante
  -- Postcondition : /
  -- Exception : LONGUEUR_MAX
  procedure Ecrire_Monome_Pere(p : in polynome; resultat : in out str; puissance : in integer; fin_constante : in integer) is
    t : integer;
    nouvelle_longueur : integer;
  begin
    if puissance /= 0 then
      -- Calcul de la place nécéssaire à l'écriture de la variable
      t := 1 + Integer'Image(puissance)'Length - 1;
      nouvelle_longueur := resultat.longueur + t;

      if nouvelle_longueur > CMAX then
        raise LONGUEUR_MAX;
      else
        -- Décaler les caractères après la constante
        for i in 1..(resultat.longueur - fin_constante) loop
          resultat.valeur(nouvelle_longueur - i + 1) := resultat.valeur(resultat.longueur - i + 1);
        end loop; 

        -- Ecrire la variable à la position fin_constante
        resultat.longueur := fin_constante;
        Ecrire_Caractere(resultat, Ap_Valeur(p).var);
        Ecrire_Entier(resultat, puissance);
        resultat.longueur := nouvelle_longueur; 
      end if;
    end if;

    -- Parcourir les pères
    if not(Ap_Est_Racine(p)) then
      Ecrire_Monome_Pere(Ap_Pere(p), resultat, Ap_Valeur(p).puiss, fin_constante);
    end if;
  end Ecrire_Monome_Pere;

  -- procedure Ecrire_Monome
  -- Sémantique : Ecrit le monome dans le resultat
  -- Paramètres : p : polynome (D)
  --              resultat : str (D/R)
  -- Précondition : Ap_Valeur(p).const /= 0
  -- Postcondition : le monome p est écrit
  -- Exception : LONGUEUR_MAX
  procedure Ecrire_Monome(p : in polynome; resultat : in out str) is
  begin
    -- Ecrire le signe
    if Ap_Valeur(p).const >= 0 then
      Ecrire_Caractere(resultat, '+');
    else
      Ecrire_Caractere(resultat, '-');
    end if;

    -- Ecrire la constante
    Ecrire_Entier(resultat, abs(Ap_Valeur(p).const));

    -- Parcourir les pères
    if not(Ap_Est_Racine(p)) then
      Ecrire_Monome_Pere(Ap_Pere(p), resultat, Ap_Valeur(p).puiss, resultat.longueur);
    end if;
  end Ecrire_Monome;

  -- Procedure Decoder_Aux
  -- Sémantique : Parcours les constantes de l'arbre
  -- Paramètres : p : polynome (D)
  --              resultat : str (D/R)
  -- Précondition : p n'est pas l'arbre vide
  -- Postcondition : /
  -- Exception : LONGUEUR_MAX
  procedure Decoder_Aux(p : in polynome; resultat : in out str) is
  begin
    if Ap_Valeur(p).const /= 0 then -- constante
      Ecrire_Monome(p, resultat);
    else
      Decoder_Aux(Ap_Fils(p), resultat); -- Parcourir les fils
    end if;

    -- Parcourir les frères
    if Ap_Frere_Existe(p) then
      Decoder_Aux(Ap_Frere(p), resultat);
    end if;
  end Decoder_Aux;

  -- Fonction Decoder
  -- Sémantique : Prend un polynôme et retourne la chaine de caractères correspondante
  -- Paramètres : p : polynome (D)
  -- Type retour : str
  -- Précondition : /
  -- Postcondition : la chaine de caractère vérifie les contraintes du sujet
  -- Exception : LONGUEUR_MAX
  function Decoder(p : in polynome) return str is
    resultat : str;
  begin
    -- Initialiser le resultat
    resultat.longueur := 0;

    if not(Ap_Vide(p)) then
      -- Parcourir chaque constante
      Decoder_Aux(p, resultat);
    end if;

    return resultat;
  end Decoder;

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
    p2_copie, somme, resultat, autre_fils : polynome;
  begin
    -- Copie de p2, en mettant la puissance 0 à la racine
    p2_copie := Ap_Copier_Sans_Frere(p2);
    n := Ap_Valeur(p2);
    n.puiss := 0;
    Ap_Changer_Valeur(p2_copie, n);

    if Ap_Valeur(Ap_Fils(p1)).puiss = 0 then -- p1 a un fils de puissance 0
      
      -- Ajouter la copie de p2 avec ce fils
      somme := Ajouter(Ap_Fils(p1), p2_copie);

      if Ap_Vide(somme) and not(Ap_Frere_Existe(Ap_Fils(p1))) then -- resultat nulle, et pas d'autre fils
        return Ap_Creer_Vide;
      else
        resultat := Ap_Copier_Sans_Frere(p1);
        Ap_Supprimer_Fils(resultat, 1);

        if not(Ap_Vide(somme)) then
          Ap_Inserer_Fils(resultat, somme);
        end if;

        return resultat;
      end if;
    else -- p1 n'a pas de fils de puissance 0
      resultat := Ap_Copier_Sans_Frere(p1);
      Ap_Inserer_Fils(resultat, p2_copie);

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
    sp1, sp2, somme, copie : polynome;
  begin
    -- copie de la racine
    resultat := Ap_Creer_Feuille(Ap_Valeur(p1));

    -- Parcours des fils
    sp1 := Ap_Fils(p1);
    sp2 := Ap_Fils(p2);

    loop
      if Ap_Vide(sp2) then -- sp2 vide
        copie := Ap_Copier_Sans_Frere(sp1);
        Ap_Inserer_Dernier_Fils(resultat, copie);

        sp1 := Ap_Frere(sp1);
      elsif Ap_Vide(sp1) then -- sp1 vide
        copie := Ap_Copier_Sans_Frere(sp2);
        Ap_Inserer_Dernier_Fils(resultat, copie);

        sp2 := Ap_Frere(sp2);
      elsif Ap_Valeur(sp1).puiss = Ap_Valeur(sp2).puiss then -- sp1 et sp2 ont la même puissance
        somme := Ajouter(sp1, sp2);

        if not(Ap_Vide(somme)) then -- si la somme n'est pas nulle
          Ap_Inserer_Dernier_Fils(resultat, somme);
        end if;

        sp1 := Ap_Frere(sp1);
        sp2 := Ap_Frere(sp2);
      elsif Ap_Valeur(sp1).puiss < Ap_Valeur(sp2).puiss then -- puissance de sp1 plus petite que sp2
        copie := Ap_Copier_Sans_Frere(sp1);
        Ap_Inserer_Dernier_Fils(resultat, copie);

        sp1 := Ap_Frere(sp1);
      else -- puissance de sp1 plus grande que sp2
        copie := Ap_Copier_Sans_Frere(sp2);
        Ap_Inserer_Dernier_Fils(resultat, copie);

        sp2 := Ap_Frere(sp2);
      end if;

      exit when Ap_Vide(sp1) and Ap_Vide(sp2);
    end loop;
    -- Ap_Vide(sp1) and Ap_Vide(sp2)

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
    if Ap_Vide(p1) and Ap_Vide(p2) then -- p1 et p2 sont vides
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
