//c2t burn
//c2t

//burns all health on a blood spell or burns all charges of the Powerful Glove on a cheat code
//alternatively, multi-casts blood skills and powerful glove skills

import <zlib.ash>


//burns all health on a skill
//spell is one of Blood Bubble, Blood Bond, or Blood Frenzy
//returns true if successfully uses spell at least 1 time
boolean c2t_bloodBurn(skill spell);
//multicast version
//num is number of times to cast spell
boolean c2t_bloodMulti(int num,skill spell);
boolean c2t_bloodMulti(string num,skill spell);


//burns all Powerful Glove charges on a cheat code
//spell is one of triple size or invisible avatar
//returns true if successfully uses spell at least 1 time
boolean c2t_tripleBurn(skill spell);
//multicast version
//num is number of times to cast spell
boolean c2t_tripleMulti(int num,skill spell);
boolean c2t_tripleMulti(string num,skill spell);


//helper function
int _c2t_s2i(string num);


//handler if script is called directly via cli
//arg is whichever case that is wanted to enter
void main(string arg) {
	string [int] split = split_string(arg," ");
	string str,val;

	if (_c2t_s2i(split[0]) > 0 || split[0] == '*') {
		val = split[0];
		//all of zlib for this
		str = list_remove(arg,val," ");
	}
	else {
		val = '*';
		str = arg;
	}

	switch (to_lower_case(str)) {
		case 'blood bubble':
		case 'bubble':
			c2t_bloodMulti(val,$skill[Blood Bubble]);
			break;
		case 'blood bond':
		case 'bond':
			c2t_bloodMulti(val,$skill[Blood Bond]);
			break;
		case 'blood frenzy':
		case 'frenzy':
			c2t_bloodMulti(val,$skill[Blood Frenzy]);
			break;
		case 'triple size':
		case 'triple':
			c2t_tripleMulti(val,$skill[CHEAT CODE: Triple Size]);
			break;
		case 'invisible avatar':
		case 'invisible':
		case 'invis':
			c2t_tripleMulti(val,$skill[CHEAT CODE: Invisible Avatar]);
			break;
		default:
			abort(`invalid argument: {arg}`);
	}
}

//casting directly to int gives spooky warning to end user; casting to float first seems to suppress it
int _c2t_s2i(string num) {
	return num.to_float().to_int();
}

//wrapper functions for scripts
boolean c2t_bloodBurn(skill spell) {
	return c2t_bloodMulti('*',spell);
}
boolean c2t_bloodMulti(int num,skill spell) {
	return c2t_bloodMulti(num.to_string(),spell);
}
boolean c2t_tripleBurn(skill spell) {
	return c2t_tripleMulti('*',spell);
}
boolean c2t_tripleMulti(int num,skill spell) {
	return c2t_tripleMulti(num.to_string(),spell);
}

//multicast blood spells
boolean c2t_bloodMulti(string num,skill spell) {
	int max = my_hp()%30 > 0 ? my_hp()/30 : (my_hp()/30)-1;
	int casts = (_c2t_s2i(num) > 0?_c2t_s2i(num):(num == '*'?max:0));

	//errors
	if (!have_skill(spell)) {
		print(`{spell} is not a skill that you have.`,"red");
		return false;
	}
	if (spell != $skill[Blood Bubble] && spell != $skill[Blood Bond] && spell != $skill[Blood Frenzy]) {
		print(`{spell} is an invalid skill to burn health`,"red");
		return false;
	}
	if (max <= 0) {
		print(`HP too low to cast {spell}.`,"red");
		return false;
	}
	if (casts == 0) {
		print(`"{num}" is invalid for number of times to cast {spell}.`,"red");
		return false;
	}
	if (casts > max) {
		print(`Cannot cast {spell} {casts} times. Will cast it {max} times though.`,"blue");
		casts = max;
	}

	//do the thing
	return use_skill(casts,spell);
}

//multicast powerful glove spells
boolean c2t_tripleMulti(string num,skill spell) {
	int max = 20 - get_property('_powerfulGloveBatteryPowerUsed').to_int()/5;
	int casts = (_c2t_s2i(num) > 0?_c2t_s2i(num):(num == '*'?max:0));

	//errors
	if (available_amount($item[Powerful Glove]) == 0) {
		print("Powerful Glove not found to use","red");
		return false;
	}
	if (spell != $skill[CHEAT CODE: Triple Size] && spell != $skill[CHEAT CODE: Invisible Avatar]) {
		print(`{spell} is an invalid skill to use Powerful Glove charges`,"red");
		return false;
	}
	if (max <= 0) {
		print("Powerful Glove charges already used","red");
		return false;
	}
	if (casts == 0) {
		print(`"{num}" is invalid for number of times to cast {spell}.`,"red");
		return false;
	}
	if (casts > max) {
		print(`Cannot cast {spell} {casts} times. Will cast it {max} times though.`,"blue");
		casts = max;
	}

	//swap in powerful glove to acc3 if need be; fourth implementation at trying to make a swap work 100% is a charm?
	item ite = $item[none];
	if (!have_equipped($item[Powerful Glove])) {
 		ite = equipped_item($slot[acc3]);
		equip($slot[acc3],$item[Powerful Glove]);
	}

	//this will spam the CLI, so give some heads up:
	if (casts > 1)
		print(`Casting {spell} {casts} times...`,"blue");
	//do the thing
	for i from 1 to casts
		use_skill(1,spell);

	//reequip former acc3 item
	if (ite != $item[none])
		equip($slot[acc3],ite);

	return true;
}

