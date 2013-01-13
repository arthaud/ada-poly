with ada.text_io; use ada.text_io;
with ada.integer_text_io; use ada.integer_text_io;

---------------------------------
-- Paquetage arbre de polynôme
---------------------------------
package body p_arbre_poly is

  ------------------
  -- 1 - CREATION --
  ------------------

  -- Fonction Ap_Creer_Vide
  -- Sémantique : Créer un arbre polynôme vide
  -- Paramètres : /
  -- Type retour : arbre_poly
  -- Précondition : /
  -- Postcondition : Un arbre_poly (vide) existe
  -- Exception : /
  function Ap_Creer_Vide return arbre_poly is
  begin
    return Null;
  end Ap_Creer_Vide;

  -- Fonction Ap_Creer_Feuille
  -- Sémantique : Créer un arbre polynôme avec une valeur mais sans fils, ni frère, ni père
  -- Paramètres : nouveau : noeud (D)
  -- Type retour : arbre_poly
  -- Précondition : /
  -- Postcondition : Un arbre avec uniquement une seule valeur existe
  -- Exception : /
  function Ap_Creer_Feuille(nouveau : in noeud) return arbre_poly is
    p : arbre_poly;
  begin
    p := new arbre_poly_contenu;
    p.all.valeur := nouveau;
    p.all.fils := Null;
    p.all.pere := Null;
    p.all.frere := Null;
    return p;
  end Ap_Creer_Feuille;

  ----------------------
  -- 2 - Consultation --
  ----------------------

  -- Fonction Ap_Vide
  -- Sémantique : Détecter si un arbre polynôme est vide ou non
  -- Paramètres : a : arbre_poly (D)
  -- Type retour : booléen (vaut vrai si l'arbre est vide)
  -- Précondition : /
  -- Postcondition : /
  -- Exception : /
  function Ap_Vide(a : in arbre_poly) return boolean is
  begin
    return (a = Null);
  end Ap_Vide;

  -- Fonction Ap_Valeur
  -- Sémantique : Retourne la valeur rangée à la racine d'un arbre
  -- Paramètres : a : arbre_poly (D)
  -- Type retour : noeud
  -- Précondition : /
  -- Postcondition : La valeur à la racine est retournée
  -- Exception : ARBRE_VIDE
  function Ap_Valeur(a : in arbre_poly) return noeud is
  begin
    if a = Null then
      raise ARBRE_VIDE;
    else
      return a.all.valeur;
    end if;
  end Ap_Valeur;

  -- Fonction Ap_Pere
  -- Sémantique : Retourne l'arbre père d'un arbre
  -- Paramètres : a : arbre_poly (D)
  -- Type retour : arbre_poly
  -- Précondition : /
  -- Postcondition : Le père de a est retourné
  -- Exception : ARBRE_VIDE, PERE_ABSENT
  function Ap_Pere(a : in arbre_poly) return arbre_poly is
  begin
    if a = Null then
      raise ARBRE_VIDE;
    elsif a.all.pere = Null then
      raise PERE_ABSENT;
    else
      return a.all.pere;
    end if;
  end Ap_Pere;

  -- Fonction Ap_Frere
  -- Sémantique : Retourne le premier frère d'un arbre
  -- Paramètres : a : arbre_poly (D)
  -- Type retour : arbre_poly
  -- Précondition : /
  -- Postcondition : Le premier frère de a est retourné
  -- Exception : ARBRE_VIDE, FRERE_ABSENT
  function Ap_Frere(a : in arbre_poly) return arbre_poly is
  begin
    if a = Null then
      raise ARBRE_VIDE;
    elsif a.all.frere = Null then
      raise FRERE_ABSENT;
    else
      return a.all.frere;
    end if;
  end Ap_Frere;

  -- Fonction Ap_Frere_Existe
  -- Sémantique : Indique si un arbre polynôme a au moins un frère
  -- Paramètres : a : arbre_poly (D)
  -- Type retour : booléen (vaut vrai si l'arbre a au moins un frère)
  -- Précondition : /
  -- Postcondition : /
  -- Exception : ARBRE_VIDE
  function Ap_Frere_Existe(a : in arbre_poly) return boolean is
  begin
    if a = Null then
      raise ARBRE_VIDE;
    else
      return (a.all.frere /= Null);
    end if;
  end Ap_Frere_Existe;

  -- Fonction Ap_Fils
  -- Sémantique : Retourne le premier fils d'un arbre
  -- Paramètres : a : arbre_poly (D)
  -- Type retour : arbre_poly
  -- Précondition : /
  -- Postcondition : Le premier fils de a est retourné
  -- Exception : ARBRE_VIDE, FILS_ABSENT
  function Ap_Fils(a : in arbre_poly) return arbre_poly is
  begin
    if a = Null then
      raise ARBRE_VIDE;
    elsif a.all.fils = Null then
      raise FILS_ABSENT;
    else
      return a.all.fils;
    end if;
  end Ap_Fils;

  -------------------------
  -- Procédure Ap_Afficher_Aux
  -- Sémantique: Affiche un arbre non vide en créant un décalage
  -- Paramètres: a: arbre_poly (D), decal: integer (D)
  -- Précondition: arbre non vide
  -- Postcondition: /
  -- Exception: /
  -------------------------
  procedure Ap_Afficher_Aux (a: in arbre_poly; decal:in integer) is
  begin
    if a /= null then
      -- decaler de decal espaces
      for i in 1..decal loop
        put(" ");
      end loop;
      -- ecrire la valeur du noeud
      put(a.all.valeur.puiss, 3);
      put(".");
      if a.all.valeur.const = 0 then
        put(a.all.valeur.var);
      else
        put(a.all.valeur.const, 3);
      end if;
      new_line;
      -- afficher le fils
      Ap_Afficher_Aux(a.all.fils, decal+2);
      -- afficher le frere
      Ap_Afficher_Aux(a.all.frere, decal);
    else
      -- rien
      null;
    end if;
  end Ap_Afficher_Aux;

  -- Procédure Ap_Afficher
  -- Sémantique : Afficher le contenu complet d'un arbre
  -- Paramètres : a : arbre_poly (D)
  -- Précondition : /
  -- Postcondition : /
  -- Exception : ARBRE_VIDE
  procedure Ap_Afficher (a: in arbre_poly) is
  begin
    if a = null then
      raise ARBRE_VIDE;
    else
      Ap_Afficher_Aux(a, 0);
    end if;
  end Ap_Afficher;

  -- Fonction Ap_Est_Feuille
  -- Sémantique : Indiquer si un arbre est une feuille (pas de fils)
  -- Paramètres : a : arbre_poly (D)
  -- Type retour : booléen (vaut vrai si l'arbre n'a pas de fils)
  -- Précondition : /
  -- Postcondition : /
  -- Exception : ARBRE_VIDE
  function Ap_Est_Feuille(a : in arbre_poly) return boolean is
  begin
    if a = Null then
      raise ARBRE_VIDE;
    else
      return (a.all.fils = Null);
    end if;
  end Ap_Est_Feuille;

  -- Fonction Ap_Est_Racine
  -- Sémantique : Indiquer si un arbre est sans père
  -- Paramètres : a : arbre_poly (D)
  -- Type retour : booléen (vaut vrai si l'arbre n'a pas de père)
  -- Précondition : /
  -- Postcondition : /
  -- Exception : ARBRE_VIDE
  function Ap_Est_Racine(a : in arbre_poly) return boolean is
  begin
    if a = Null then
      raise ARBRE_VIDE;
    else
      return (a.all.pere = Null);
    end if;
  end Ap_Est_Racine;

  ----------------------
  -- 3 - MODIFICATION --
  ----------------------

  -- Procédure Ap_Changer_Valeur
  -- Sémantique : Changer la valeur rangée à la racine d'un arbre
  -- Paramètres : a : arbre_poly (D/R)
  --              nouveau : noeud (D)
  -- Précondition : /
  -- Postcondition : La racine de l'arbre est modifiée
  -- Exception : ARBRE_VIDE
  procedure Ap_Changer_Valeur(a : in out arbre_poly; nouveau : in noeud) is
  begin
    if a = Null then
      raise ARBRE_VIDE;
    else
      a.all.valeur := nouveau;
    end if;
  end Ap_Changer_Valeur;

  -- Procédure Ap_Inserer_Fils
  -- Sémantique : Insérer un arbre sans frère en position de premier fils d'un arbre a. L'ancien fils de a devient alors le premier frère de l'arbre inséré.
  -- Paramètres : a : arbre_poly (D/R)
  --              a_ins : arbre_poly (D/R)
  -- Précondition : a_ins n'a pas de frère
  -- Postcondition : a_ins est inséré en position de premier fils de a
  -- Exception : ARBRE_VIDE
  procedure Ap_Inserer_Fils(a : in out arbre_poly; a_ins: in out arbre_poly) is
  begin
    if a = Null or a_ins = Null then
      raise ARBRE_VIDE;
    else
      a_ins.all.frere := a.all.fils;
      a_ins.all.pere := a;
      a.all.fils := a_ins;
    end if;
  end Ap_Inserer_Fils;

  -- Procédure Ap_Inserer_Frere
  -- Sémantique : Insérer un arbre sans frère en position de premier frère d'un arbre a
  -- Paramètres : a : arbre_poly (D/R)
  --              a_ins : arbre_poly (D/R)
  -- Précondition : a_ins n'a pas de frère
  -- Postcondition : a_ins est inséré en position de premier frère de a
  -- Exception : ARBRE_VIDE
  procedure Ap_Inserer_Frere(a : in out arbre_poly; a_ins : in out arbre_poly) is
  begin
    if a = Null or a_ins = Null then
      raise ARBRE_VIDE;
    else
      a_ins.all.pere := a.all.pere;
      a_ins.all.frere := a.all.frere;
      a.all.frere := a_ins;
    end if;
  end Ap_Inserer_Frere;

  -- Procédure Ap_Inserer_Dernier_Fils
  -- Sémantique : Insérer un arbre en position de dernier fils d'un arbre a
  -- Paramètres : a : arbre_poly (D/R)
  --              a_ins : arbre_poly (D/R)
  -- Précondition : /
  -- Postcondition : a_ins est inséré en position de dernier fils de a
  -- Exception : ARBRE_VIDE
  procedure Ap_Inserer_Dernier_Fils(a : in out arbre_poly; a_ins : in out arbre_poly) is
  begin
    if a = Null or a_ins = Null then -- arbre vide
      raise ARBRE_VIDE;
    elsif a.all.fils = Null then -- arbre sans fils
      a_ins.all.pere := a;
      a.all.fils := a_ins;
    else
      -- Insérer a_ins en dernier frère du premier fils
      Ap_Inserer_Dernier_Frere(a.all.fils, a_ins);
    end if;
  end Ap_Inserer_Dernier_Fils;

  -- Procédure Ap_Inserer_Dernier_Frere
  -- Sémantique : Insérer un arbre en position de dernier frère d'un arbre a
  -- Paramètres : a : arbre_poly (D/R)
  --              a_ins : arbre_poly (D/R)
  -- Précondition : /
  -- Postcondition : a_ins est inséré en position de dernier frère de a
  -- Exception : ARBRE_VIDE
  procedure Ap_Inserer_Dernier_Frere(a : in out arbre_poly; a_ins : in out arbre_poly) is
    temp : arbre_poly;
  begin
    if a = Null or a_ins = Null then -- arbre vide
      raise ARBRE_VIDE;
    else
      -- Initialisation
      temp := a;

      while temp.all.frere /= Null loop -- arret lors du dernier frère
        temp := temp.all.frere;
      end loop;

      -- Insertion sur le dernier frère
      a_ins.all.pere := a.all.pere;
      temp.all.frere := a_ins;
    end if;
  end Ap_Inserer_Dernier_Frere;

  -- Fonction Ap_Copier
  -- Sémantique : Copier un arbre
  -- Paramètres : a : arbre_poly (D)
  -- Type retour : arbre_poly
  -- Précondition : /
  -- Postcondition : a est copié
  -- Exception : /
  function Ap_Copier(a : in arbre_poly) return arbre_poly is
    resultat : arbre_poly;
    fils : arbre_poly;
    frere : arbre_poly;
  begin
    if a = Null then -- arbre vide
      return Null;
    else
      -- copie de la racine
      resultat := Ap_Creer_Feuille(Ap_Valeur(a));

      -- copie des frères
      if a.all.frere /= Null then
        frere := Ap_Copier(a.all.frere);
        resultat.all.frere := frere;
      end if;

      -- copie des fils
      if a.all.fils /= Null then
        fils := Ap_Copier(a.all.fils);
        resultat.all.fils := fils;
        fils.all.pere := resultat;
      end if;

      return resultat;
    end if;
  end Ap_Copier;

end p_arbre_poly;
