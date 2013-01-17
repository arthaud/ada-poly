with ada.text_io; use ada.text_io;

------------------------------------------
-- Paquetage arbre naire de caracteres
------------------------------------------
package body p_arbren is

  ------------------
  -- 1 - CREATION --
  ------------------

  -- Fonction An_Creer_Vide
  -- Sémantique : Créer un arbre n-aire vide
  -- Paramètres : /
  -- Type retour : arbren
  -- Précondition : /
  -- Postcondition : Un arbren (vide) existe
  -- Exception : /
  function An_Creer_Vide return arbren is
  begin
    return Null;
  end An_Creer_Vide;

  -- Fonction An_Creer_Feuille
  -- Sémantique : Créer un arbre n-aire avec une valeur mais sans fils, ni frère, ni père
  -- Paramètres : nouveau : character (D)
  -- Type retour : arbren
  -- Précondition : /
  -- Postcondition : Un arbre avec uniquement une seule valeur existe
  -- Exception : /
  function An_Creer_Feuille(nouveau : in character) return arbren is
    p : arbren;
  begin
    p := new noeud;
    p.all.valeur := nouveau;
    p.all.fils := Null;
    p.all.pere := Null;
    p.all.frere := Null;
    return p;
  end An_Creer_Feuille;	

  ----------------------
  -- 2 - Consultation --
  ----------------------

  -- Fonction An_Vide
  -- Sémantique : Détecter si un arbren est vide ou non
  -- Paramètres : a : arbren (D)
  -- Type retour : booléen (vaut vrai si l'arbre est vide)
  -- Précondition : /
  -- Postcondition : /
  -- Exception : /
  function An_Vide(a : in arbren) return boolean is
  begin
    return (a = Null);
  end An_Vide;

  -- Fonction An_Valeur
  -- Sémantique : Retourne la valeur rangée à la racine d'un arbre
  -- Paramètres : a : arbren (D)
  -- Type retour : character
  -- Précondition : /
  -- Postcondition : La valeur à la racine est retournée
  -- Exception : ARBRE_VIDE
  function An_Valeur(a : in arbren) return character is
  begin
    if a = Null then
      raise ARBRE_VIDE;
    else
      return a.all.valeur;
    end if;
  end An_Valeur;

  -- Fonction An_Pere
  -- Sémantique : Retourne l'arbre père d'un arbre
  -- Paramètres : a : arbren (D)
  -- Type retour : arbren
  -- Précondition : /
  -- Postcondition : Le père de a est retourné
  -- Exception : ARBRE_VIDE, PERE_ABSENT
  function An_Pere(a : in arbren) return arbren is
  begin
    if a = Null then
      raise ARBRE_VIDE;
    elsif a.all.pere = Null then
      raise PERE_ABSENT;
    else
      return a.all.pere;
    end if;
  end An_Pere;

  -------------------------
  -- Procédure An_Afficher_Aux
  -- Sémantique: Affiche un arbre non vide en créant un décalage
  -- Paramètres: a: arbren (D), decal: integer (D)
  -- Précondition: arbre non vide
  -- Postcondition: /
  -- Exception: /
  -------------------------
  procedure An_Afficher_Aux (a: in arbren; decal:in integer) is
  begin
    if a /= null then 
      -- decaler de decal espaces
      for i in 1..decal loop
        put(" ");
      end loop;
      -- ecrire la valeur du noeud
      put(a.all.valeur);
      new_line;
      -- afficher le fils
      An_Afficher_Aux(a.all.fils,decal+2);
      -- afficher le frere
      An_Afficher_Aux(a.all.frere,decal);
    else 
      -- rien
      null;
    end if;
  end An_Afficher_Aux;

  -------------------------
  -- Procédure An_Afficher
  -- Sémantique: Afficher le contenu complet d'un arbre
  -- Paramètres: a: arbren (D)
  -- Précondition: /
  -- Postcondition: /
  -- Exception: ARBRE_VIDE
  ------------------------
  procedure An_Afficher (a: in arbren) is
  begin
    if a = null then 
      raise ARBRE_VIDE;
    else 
      An_Afficher_Aux(a,0);
    end if;
  end An_Afficher;

  -- Fonction An_Rechercher
  -- Sémantique : Recherche une valeur dans un arbre et retourne l'arbre dont la valeur est racine si elle est trouvée, un arbre vide sinon
  -- Paramètres : a : arbren (D)
  --              data : character (D)
  -- Type retour : arbren
  -- Précondition : /
  -- Postcondition : Un arbre est retourné (vide éventuellement)
  -- Exception : /
  function An_Rechercher(a : in arbren; data : in character) return arbren is
    p : arbren;
  begin
    if a = Null or else a.all.valeur = data then
      return a;
    else
      p := An_Rechercher(a.all.frere, data);

      if p /= Null then
        return p;
      else
        return An_Rechercher(a.all.fils, data);
      end if;
    end if;	
  end An_Rechercher;

  -- Fonction An_Est_Feuille
  -- Sémantique : Indiquer si un arbre est une feuille (pas de fils)
  -- Paramètres : a : arbren (D)
  -- Type retour : booléen (vaut vrai si l'arbre n'a pas de fils)
  -- Précondition : /
  -- Postcondition : /
  -- Exception : ARBRE_VIDE
  function An_Est_Feuille(a : in arbren) return boolean is
  begin
    if a = Null then
      raise ARBRE_VIDE;
    else
      return (a.all.fils = Null);
    end if;
  end An_Est_Feuille;

  -- Fonction An_Est_Racine
  -- Sémantique : Indiquer si un arbre est sans père
  -- Paramètres : a : arbren (D)
  -- Type retour : booléen (vaut vrai si l'arbre n'a pas de père)
  -- Précondition : /
  -- Postcondition : /
  -- Exception : ARBRE_VIDE
  function An_Est_Racine(a : in arbren) return boolean is
  begin
    if a = Null then
      raise ARBRE_VIDE;
    else
      return (a.all.pere = Null);
    end if;
  end An_Est_Racine;

  ----------------------
  -- 3 - MODIFICATION --
  ----------------------

  -- Procédure An_Changer_Valeur
  -- Sémantique : Changer la valeur rangée à la racine d'un arbre
  -- Paramètres : a : arbren (D/R)
  --              nouveau : character (D)
  -- Précondition : /
  -- Postcondition : La racine de l'arbre est modifiée
  -- Exception : ARBRE_VIDE
  procedure An_Changer_Valeur(a : in out arbren; nouveau : in character) is
  begin
    if a = Null then
      raise ARBRE_VIDE;
    else
      a.all.valeur := nouveau;
    end if;
  end An_Changer_Valeur;

  -- Procédure An_Inserer_Fils
  -- Sémantique : Insérer un arbre sans frère en position de premier fils d'un arbre a. L'ancien fils de a devient alors le premier frère de l'arbre inséré.
  -- Paramètres : a : arbren (D/R)
  --              a_ins : arbren (D/R)
  -- Précondition : a_ins n'a pas de frère
  -- Postcondition : a_ins est inséré en position de premier fils de a
  -- Exception : ARBRE_VIDE
  procedure An_Inserer_Fils(a : in out arbren; a_ins: in out arbren) is
  begin
    if a = Null or a_ins = Null then
      raise ARBRE_VIDE;
    else
      a_ins.all.frere := a.all.fils;
      a_ins.all.pere := a;
      a.all.fils := a_ins;
    end if;
  end An_Inserer_Fils;

  -- Procédure An_Inserer_Frere
  -- Sémantique : Insérer un arbre sans frère en position de premier frère d'un arbre a
  -- Paramètres : a : arbren (D/R)
  --              a_ins : arbren (D/R)
  -- Précondition : a_ins n'a pas de frère
  -- Postcondition : a_ins est inséré en position de premier frère de a
  -- Exception : ARBRE_VIDE
  procedure An_Inserer_Frere(a : in out arbren; a_ins : in out arbren) is
  begin
    if a = Null or a_ins = Null then
      raise ARBRE_VIDE;
    else
      a_ins.all.pere := a.all.pere;
      a_ins.all.frere := a.all.frere;
      a.all.frere := a_ins;	
    end if;
  end An_Inserer_Frere;

  -- Procédure An_Supprimer_Fils
  -- Sémantique : Supprimer le nième fils d'un arbre
  -- Paramètres : a : arbren (D/R)
  --              n : integer (D)
  -- Précondition : n >= 1
  -- Postcondition : Le nième fils est supprimé. Les fils n+i+1 deviennent les fils n+i (i>=0).
  -- Exception : ARBRE_VIDE, FILS_ABSENT
  procedure An_Supprimer_Fils(a : in out arbren; n : in integer) is
  begin
    if a = Null then -- arbre vide
      raise ARBRE_VIDE;
    elsif a.all.fils = Null then -- arbre sans fils
      raise FILS_ABSENT;
    elsif n = 1 then -- n=1
      a.all.fils := a.all.fils.all.frere;
    else
      begin
        -- Supprime le (n-1)ième frère du premier fils
        An_Supprimer_Frere(a.all.fils, n-1);
      exception
        when FRERE_ABSENT => raise FILS_ABSENT;
      end;
    end if;
  end An_Supprimer_Fils;

  -- Procédure An_Supprimer_Frere
  -- Sémantique : Supprimer le nième frère d'un arbre
  -- Paramètres : a : arbren (D/R)
  --              n : integer (D)
  -- Précondition : n >= 1
  -- Postcondition : Le nième frère est supprimé. Les frères n+i+1 deviennent les frères n+i (i>=0).
  -- Exception : ARBRE_VIDE, FRERE_ABSENT
  procedure An_Supprimer_Frere(a : in out arbren; n : in integer) is
    temp : arbren;
    p : integer;
  begin
    if a = Null then -- arbre vide
      raise ARBRE_VIDE;
    else
      -- Parcours des frères

      -- Initialisation
      temp := a;
      p := 1;

      -- Parcours
      while temp.all.frere /= Null and p < n loop
        temp := temp.all.frere;
        p := p+1;
      end loop;
      -- temp.all.frere = Null or p=n

      -- Fin de Parcours des frères

      -- Supprimer le nième frère s'il existe, sinon lever une exception
      if p=n and temp.all.frere /= Null then
        temp.all.frere := temp.all.frere.all.frere;	
      else
        raise FRERE_ABSENT;
      end if;
    end if;
  end An_Supprimer_Frere;

end p_arbren;
