//c2t
//c2t_burn
//2020.10.26
//burns all health on a blood spell or burns all charges of the Powerful Glove on a cheat code


//burns all health on a skill
//spell is one of Blood Bubble, Blood Bond, or Blood Frenzy
void c2t_bloodBurn(skill spell);

//burns all Powerful Glove charges on a cheat code
//spell is one of triple size or invisible avatar
void c2t_tripleBurn(skill spell);

//handler if script is called directly
//arg is whichever case that is wanted to enter
void main(string arg) {
	switch (arg) {
		case 'bubble':
			c2t_bloodBurn($skill[Blood Bubble]);
			break;
		case 'bond':
			c2t_bloodBurn($skill[Blood Bond]);
			break;
		case 'frenzy':
			c2t_bloodBurn($skill[Blood Frenzy]);
			break;
		case 'triple':
			c2t_tripleBurn($skill[CHEAT CODE: Triple Size]);
			break;
		case 'invisible':
		case 'invis':
			c2t_tripleBurn($skill[CHEAT CODE: Invisible Avatar]);
			break;
		default:
			abort('invalid argument');
	}
}

void c2t_bloodBurn(skill spell) {
	if (spell == $skill[Blood Bubble] || spell == $skill[Blood Bond] || spell == $skill[Blood Frenzy]) {
		int casts = my_hp()%30 > 0 ? my_hp()/30 : (my_hp()/30)-1;
		if (have_skill(spell) && casts > 0)
			use_skill(casts,spell);	
		else if (!have_skill(spell))
			print(spell+" not found to burn with","red");
		else
			print("Health already at 30 or less","blue");
	}
	else
		print(spell+" is an invalid skill to burn health","red");
}

void c2t_tripleBurn(skill spell) {
	if (spell == $skill[CHEAT CODE: Triple Size] || spell == $skill[CHEAT CODE: Invisible Avatar]) {
		if (available_amount($item[Powerful Glove]) > 0) {
			if (get_property('_powerfulGloveBatteryPowerUsed').to_int() < 100) {
				cli_execute('outfit save backup');
				equip($slot[acc3],$item[Powerful Glove]);
				while (get_property('_powerfulGloveBatteryPowerUsed').to_int() < 100)
					use_skill(1,spell);
				cli_execute('outfit backup');
			}
			else
				print("Powerful Glove charges already used","blue");
		}
		else
			print("Powerful Glove not found to burn","red");
	}
	else
		print(spell+" is an invalid skill to burn Powerful Glove charges","red");
}

