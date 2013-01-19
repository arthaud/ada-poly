---------------------------------
-- Paquetage arbre de polynôme
---------------------------------
package p_arbre_poly is

  -- un arbre_poly est un arbre naire dont les noeuds sont de type 'noeud'
  -- les fonctions et procédures suivantes ne respectent aucun invariants
  type noeud is record
    puiss : integer; -- puissance
    var : character; -- nom de la variable
    const : integer; -- constante
  end record;
  type arbre_poly is private;

  ARBRE_VIDE : exception;
  PERE_ABSENT : exception;
  FILS_ABSENT : exception;
  FRERE_ABSENT : exception;

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
  function Ap_Creer_Vide return arbre_poly;

  -- Fonction Ap_Creer_Feuille
  -- Sémantique : Créer un arbre polynôme avec une valeur mais sans fils, ni frère, ni père
  -- Paramètres : nouveau : noeud (D)
  -- Type retour : arbre_poly
  -- Précondition : /
  -- Postcondition : Un arbre avec uniquement une seule valeur existe
  -- Exception : /
  function Ap_Creer_Feuille(nouveau : in noeud) return arbre_poly;

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
  function Ap_Vide(a : in arbre_poly) return boolean;

  -- Fonction Ap_Valeur
  -- Sémantique : Retourne la valeur rangée à la racine d'un arbre
  -- Paramètres : a : arbre_poly (D)
  -- Type retour : noeud
  -- Précondition : /
  -- Postcondition : La valeur à la racine est retournée
  -- Exception : ARBRE_VIDE
  function Ap_Valeur(a : in arbre_poly) return noeud;

  -- Fonction Ap_Pere
  -- Sémantique : Retourne l'arbre père d'un arbre, ou l'arbre vide s'il n'en a pas
  -- Paramètres : a : arbre_poly (D)
  -- Type retour : arbre_poly
  -- Précondition : /
  -- Postcondition : Le père de a est retourné (vide eventuellement)
  -- Exception : ARBRE_VIDE
  function Ap_Pere(a : in arbre_poly) return arbre_poly;

  -- Fonction Ap_Frere
  -- Sémantique : Retourne le premier frère d'un arbre, ou l'arbre vide s'il n'en a pas
  -- Paramètres : a : arbre_poly (D)
  -- Type retour : arbre_poly
  -- Précondition : /
  -- Postcondition : Le premier frère de a est retourné (vide eventuellement)
  -- Exception : ARBRE_VIDE
  function Ap_Frere(a : in arbre_poly) return arbre_poly;

  -- Fonction Ap_Frere_Existe
  -- Sémantique : Indique si un arbre polynôme a au moins un frère
  -- Paramètres : a : arbre_poly (D)
  -- Type retour : booléen (vaut vrai si l'arbre a au moins un frère)
  -- Précondition : /
  -- Postcondition : /
  -- Exception : ARBRE_VIDE
  function Ap_Frere_Existe(a : in arbre_poly) return boolean;
  
  -- Fonction Ap_Fils
  -- Sémantique : Retourne le premier fils d'un arbre, ou l'arbre vide s'il n'en a pas
  -- Paramètres : a : arbre_poly (D)
  -- Type retour : arbre_poly
  -- Précondition : /
  -- Postcondition : Le premier fils de a est retourné (vide eventuellement)
  -- Exception : ARBRE_VIDE
  function Ap_Fils(a : in arbre_poly) return arbre_poly;

  -- Procédure Ap_Afficher
  -- Sémantique : Afficher le contenu complet d'un arbre
  -- Paramètres : a : arbre_poly (D)
  -- Précondition : /
  -- Postcondition : /
  -- Exception : ARBRE_VIDE
  procedure Ap_Afficher(a : in arbre_poly);

  -- Fonction Ap_Est_Feuille
  -- Sémantique : Indiquer si un arbre est une feuille (pas de fils)
  -- Paramètres : a : arbre_poly (D)
  -- Type retour : booléen (vaut vrai si l'arbre n'a pas de fils)
  -- Précondition : /
  -- Postcondition : /
  -- Exception : ARBRE_VIDE
  function Ap_Est_Feuille(a : in arbre_poly) return boolean;

  -- Fonction Ap_Est_Racine
  -- Sémantique : Indiquer si un arbre est sans père
  -- Paramètres : a : arbre_poly (D)
  -- Type retour : booléen (vaut vrai si l'arbre n'a pas de père)
  -- Précondition : /
  -- Postcondition : /
  -- Exception : ARBRE_VIDE
  function Ap_Est_Racine(a : in arbre_poly) return boolean;

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
  procedure Ap_Changer_Valeur(a : in out arbre_poly; nouveau : in noeud);

  -- Procédure Ap_Inserer_Fils
  -- Sémantique : Insérer un arbre sans frère en position de premier fils d'un arbre a. L'ancien fils de a devient alors le premier frère de l'arbre inséré.
  -- Paramètres : a : arbre_poly (D/R)
  --              a_ins : arbre_poly (D/R)
  -- Précondition : a_ins n'a pas de frère
  -- Postcondition : a_ins est inséré en position de premier fils de a
  -- Exception : ARBRE_VIDE
  procedure Ap_Inserer_Fils(a : in out arbre_poly; a_ins: in out arbre_poly);

  -- Procédure Ap_Inserer_Frere
  -- Sémantique : Insérer un arbre sans frère en position de premier frère d'un arbre a
  -- Paramètres : a : arbre_poly (D/R)
  --              a_ins : arbre_poly (D/R)
  -- Précondition : a_ins n'a pas de frère
  -- Postcondition : a_ins est inséré en position de premier frère de a
  -- Exception : ARBRE_VIDE
  procedure Ap_Inserer_Frere(a : in out arbre_poly; a_ins : in out arbre_poly);

  -- Procédure Ap_Inserer_Dernier_Fils
  -- Sémantique : Insérer un arbre sans frère en position de dernier fils d'un arbre a
  -- Paramètres : a : arbre_poly (D/R)
  --              a_ins : arbre_poly (D/R)
  -- Précondition : a_ins n'a pas de frère
  -- Postcondition : a_ins est inséré en position de dernier fils de a
  -- Exception : ARBRE_VIDE
  procedure Ap_Inserer_Dernier_Fils(a : in out arbre_poly; a_ins : in out arbre_poly);

  -- Procédure Ap_Inserer_Dernier_Frere
  -- Sémantique : Insérer un arbre sans frère en position de dernier frère d'un arbre a
  -- Paramètres : a : arbre_poly (D/R)
  --              a_ins : arbre_poly (D/R)
  -- Précondition : a_ins n'a pas de frère
  -- Postcondition : a_ins est inséré en position de dernier frère de a
  -- Exception : ARBRE_VIDE
  procedure Ap_Inserer_Dernier_Frere(a : in out arbre_poly; a_ins : in out arbre_poly);

  -- Procédure Ap_Supprimer_Fils
  -- Sémantique : Supprimer le nième fils d'un arbre
  -- Paramètres : a : arbre_poly (D/R)
  --              n : integer (D)
  -- Précondition : n >= 1
  -- Postcondition : Le nième fils est supprimé. Les fils n+i+1 deviennent les fils n+i (i>=0).
  -- Exception : ARBRE_VIDE, FILS_ABSENT
  procedure Ap_Supprimer_Fils(a : in out arbre_poly; n : in integer);

  -- Procédure Ap_Supprimer_Frere
  -- Sémantique : Supprimer le nième frère d'un arbre
  -- Paramètres : a : arbre_poly (D/R)
  --              n : integer (D)
  -- Précondition : n >= 1
  -- Postcondition : Le nième frère est supprimé. Les frères n+i+1 deviennent les frères n+i (i>=0).
  -- Exception : ARBRE_VIDE, FRERE_ABSENT
  procedure Ap_Supprimer_Frere(a : in out arbre_poly; n : in integer);

  -- Fonction Ap_Copier
  -- Sémantique : Copier un arbre. Ne copie pas le père.
  -- Paramètres : a : arbre_poly (D)
  -- Type retour : arbre_poly
  -- Précondition : /
  -- Postcondition : a est copié, excepté le père
  -- Exception : /
  function Ap_Copier(a : in arbre_poly) return arbre_poly;

  -- Fonction Ap_Copier_Sans_Frere
  -- Sémantique : Copier un arbre. Ne copie pas le père et les frères de a.
  -- Paramètres : a : arbre_poly (D)
  -- Type retour : arbre_poly
  -- Précondition : /
  -- Postcondition : a est copié, excepté le père et les frères de a
  -- Exception : /
  function Ap_Copier_Sans_Frere(a : in arbre_poly) return arbre_poly;

  private
    type arbre_poly_contenu;
    type arbre_poly is access arbre_poly_contenu;
    type arbre_poly_contenu is record
      valeur : noeud;
      fils : arbre_poly;
      pere : arbre_poly;
      frere : arbre_poly;
    end record;
end p_arbre_poly;
