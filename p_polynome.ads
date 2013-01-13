with p_arbre_poly; use p_arbre_poly;

------------------------
-- Paquetage polynôme
------------------------
package p_polynome is

  type polynome is private;

  -- Fonction Encoder
  -- Sémantique : Prend un polynôme sous forme de chaine de caractères, et retourne un polynôme
  -- Paramètres : p : string (D)
  -- Type retour : polynome
  -- Précondition : p vérifie les contraintes du sujet
  -- Postcondition : le polynôme retourné est p
  -- function Encoder(p : in string) return polynome;

  -- Fonction Decoder
  -- Sémantique : Prend un polynôme et retourne la chaine de caractères correspondante
  -- Paramètres : p : polynome (D)
  -- Type retour : string
  -- Précondition : /
  -- Postcondition : le polynôme retourné est p
  -- function Decoder(p : in polynome) return string;

  -- Fonction Ajouter
  -- Sémantique : Fait l'addition de deux polynomes
  -- Paramètres : p1 : polynome (D)
  --              p2 : polynome (D)
  -- Type retour : polynome
  -- Précondition : /
  -- Postcondition : la sortie vaut p1 + p2
  function Ajouter(p1 : in polynome; p2 : in polynome) return polynome;

  private
    type polynome is new arbre_poly;
    -- Invariants respectés par le type polynome :
    -- * polynome est la racine d'un arbre naire, donc sans frère
    -- * les fils sont rangés dans l'ordre : de la plus petite puissance à la plus grande
    -- * pour un noeud, 
    --    Si const = 0, var /= ' ' et le noeud a au moins un fils
    --    Sinon const /= 0, var = ' ' et le noeud n'a aucun fils

end p_polynome;
