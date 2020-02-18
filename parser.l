%{
    int yywrap();
    void yyerror(char*);
    #include "y.tab.h"
%}
 
 
%%

[a-z]   {
            yylval.charVal = yytext[0];
            return LOWERCASE;
		}

[A-Z]	{
			yylval.charVal = yytext[0];
			return UPPERCASE;
		}

"["		{return LEFT_M_P;}
"]"		{return RIGHT_M_P;}
"{"		{return LEFT_B_P;}
"}"		{return RIGHT_B_P;}
","		{return COMMA;}

[0-9]+  {
            yylval.intVal = atoi(yytext);
            return INTEGER;
        }

[-+()=/*&|~!^@\n]  {return *yytext;}

[ \t]    ;
 
    
"."       {return DOT;}
%%
 
int yywrap()
{return 1;}
