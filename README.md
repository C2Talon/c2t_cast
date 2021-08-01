# c2t_cast

Kolmafia script to multi-cast blood spells or cheat codes, or to burn all health on blood spells or burn all charges on the Powerful Glove on a cheat code. This script is the successor to `c2t_burn`.

This script basically makes equivalents to the `cast` command on the CLI and the `use_skill()` function in ASH, but for skills that don't behave the same as most other skills with those methods. For example, normally those methods don't allow the multi-casting of powerful gloves skills. This script handles that. Another example is you can't `cast * blood bubble` normally, but you can `c2t_burn * blood bubble`.

List of skills supported:
* Blood Bond
* Blood Bubble
* Blood Frenzy
* CHEAT CODE: Invisible Avatar
* CHEAT CODE: Triple Size

## Install

To install, run the following on kolmafia's CLI:

`svn checkout https://github.com/c2talon/c2t_cast/branches/master/kolmafia/`

## Usage

### CLI

Can be used with the CLI via:
`c2t_cast [casts] <bubble | bond | frenzy | triple | invisible | invis>`
* `casts` is optional, and indicates how many times to use the skill. Without it, the script assumes to cast only once.
* `bubble` will cast Blood Bubble using health
* `bond` will cast Blood Bond using health
* `frenzy` will cast Blood Frenzy using health
* `triple` will cast Triple Size using Powerful Glove charges
* `invisible` or `invis` will cast Invisible Avatar using Powerful Glove charges

### Functions

Functions within can be called via another script when `import`ed. Each of these will return `true` if it cast something at least 1 time.

`boolean c2t_burn(skill spell)`
* This is for max-casting a blood spell or cheat code, where `spell` is the skill to use. Ex: `c2t_burn($skill[Blood Bubble])`

`boolean c2t_cast(int num,skill spell)`
* This is for multi-casting a blood spell or cheat code, where `spell` is the skill to use and `num` is the times to use it. Ex: `c2t_cast(2,$skill[CHEAT CODE: Triple Size])`

