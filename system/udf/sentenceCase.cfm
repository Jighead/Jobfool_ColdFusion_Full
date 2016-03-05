<cfscript>
function sentenceCase(initText){          
var Words = "";     
var j = 1; 
var m = 1;     
var doCap = "";     
var thisWord = "";
var excludeWords = ArrayNew(1);
var outputString = "";
initText = LCASE(initText);
//Words to never capitalize
excludeWords[1] = "an";
excludeWords[2] = "the";
excludeWords[3] = "at";
excludeWords[4] = "by";
excludeWords[5] = "for";
excludeWords[6] = "of";
excludeWords[7] = "in";
excludeWords[8] = "up";
excludeWords[9] = "on";
excludeWords[10] = "to";
excludeWords[11] = "and";
excludeWords[12] = "as";
excludeWords[13] = "but";
excludeWords[14] = "if";
excludeWords[15] = "or";
excludeWords[16] = "nor";
excludeWords[17] = "a";
excludeWords[18] = "it";
excludeWords[19] = "III";
excludeWords[19] = "II";

//Make each word in text an array variable
Words = ListToArray(initText, " ");
	//Check words against exclude list
	for(j=1; j LTE (ArrayLen(Words)); j = j+1){	
	doCap = true; 
	               
		//Word must be less that four characters to be in the list of excluded words
   		 if(LEN(Words[j]) LT 5 ){
		  if(ListFind(ArrayToList(excludeWords,","),Words[j])){
			doCap = false;
			}
		}
		//Capitalize hyphenated words 
		if(ListLen(Words[j],"-") GT 1){               
		for(m=2; m LTE ListLen(Words[j], "-"); m=m+1){                    
			thisWord = ListGetAt(Words[j], m, "-");                    
			thisWord = UCase(Mid(thisWord,1, 1)) & Mid(thisWord,2, LEN(thisWord)-1);                    
			Words[j] = ListSetAt(Words[j], m, thisWord, "-");               
			}          
		} 
						   
		//Automatically capitalize first and last words          
		if(j eq 1 or j eq ArrayLen(Words)){               
			doCap = true;
		}
		               
		//Capitalize qualifying words          
		if(doCap){               
			Words[j] = UCase(Mid(Words[j],1, 1)) & Mid(Words[j],2, LEN(Words[j])-1);
			}     
		}         
		outputString = ArrayToList(Words, " ");     
		return outputString;
 }
 </cfscript> 