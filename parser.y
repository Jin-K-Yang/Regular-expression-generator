%token   INTEGER LOWERCASE UPPERCASE LEFT_M_P RIGHT_M_P LEFT_B_P RIGHT_B_P COMMA DOT

%union {
    char    charVal;
    int     intVal;
}

%type <charVal> LOWERCASE UPPERCASE expr
%type <intVal> INTEGER size

%left    '+' '-'
%left    '*' '/'
%left    '&'
%left    '|'
%left    '^'
%right   '@''~'
%left    '!'
 
%{
    #include <stdio.h> 
    #include <stdlib.h>
    #include <time.h>
    #include <string.h>

    #define END 10
    
    void yyerror(char*);
    int yylex(void);
    int size;
    int random_number;
    int maximum_number, minimum_number,maximum_size, minimum_size;
    char min_lower, max_lower, min_upper, max_upper;
    void display ();
    void get(int lingth, char* ouput);
    char* output;
%}

 
%%
 
program:
    program statement '\n'
    |
    ;
statement:
    expr size                               {display();}
    ;
expr:
    LEFT_M_P number lowercase uppercase RIGHT_M_P                {/*empty*/}
    |LEFT_M_P number uppercase lowercase RIGHT_M_P               {/*empty*/}
    |LEFT_M_P lowercase number uppercase RIGHT_M_P               {/*empty*/}
    |LEFT_M_P lowercase uppercase number RIGHT_M_P               {/*empty*/}
    |LEFT_M_P uppercase lowercase number RIGHT_M_P               {/*empty*/}
    |LEFT_M_P uppercase number lowercase RIGHT_M_P               {/*empty*/}
    ;
size:
    INTEGER
    |LEFT_B_P size RIGHT_B_P                {minimum_size = $2; maximum_size = $2;}
    |LEFT_B_P size COMMA size RIGHT_B_P     {minimum_size = $2; maximum_size = $4;}
    |LEFT_B_P size COMMA RIGHT_B_P          {minimum_size = $2; maximum_size = END;}
    |'+'                                    {minimum_size = 1; maximum_size = END;}
    |'*'                                    {minimum_size = 0; maximum_size = END;}
    ;
number:
    INTEGER
    |                                       {minimum_number = 0; maximum_number = 0;}
    |INTEGER '-' INTEGER                    {minimum_number = $1; maximum_number = $3;}
    ;
lowercase:
    LOWERCASE
    |                                       {min_lower = '0'; max_lower = '0';}
    |LOWERCASE '-' LOWERCASE                {min_lower = $1; max_lower = $3;}
    ;
uppercase:
    UPPERCASE
    |                                       {min_upper = '0'; max_upper = '0';}
    |UPPERCASE '-' UPPERCASE                {min_upper = $1; max_upper = $3;}
    ;
    
 
%%
 
 
void yyerror(char* s)
{
    fprintf(stderr, "error %s\n", s);
}
 
int main(void)
{
    yyparse();
    return 0;
}

void display()
{
    char random[62];
    srand(time(NULL));
    size = rand() % (maximum_size - minimum_size + 1) + minimum_size;
    int count = 0;
    for(int i = minimum_number; i < maximum_number + 1; i++)
    {
        if(maximum_number == 0 && minimum_number == 0)
            break;
        sprintf(random + i - minimum_number, "%d", i);
        count++;
    }
    for(int i = 0; i < max_lower - min_lower + 1; i++)
    {
        if(max_lower == '0' && min_lower == '0')
            break;
        random[count] = min_lower + i;
        count++;
    }
    for(int i = 0; i < max_upper - min_upper + 1; i++)
    {
        if(max_upper == '0' && min_upper == '0')
            break;
        random[count] = min_upper + i;
        count++;
    }
    for(int i = 0; i < size; i++)
    {
        random_number = rand() % count;
        printf("%c", random[random_number]);
    }
    printf("\n");
}

void get(int length, char* ouput)
{
    int flag, i;
    srand((unsigned)time(NULL));
    for (i = 0; i < length - 1; i++)
    {
        flag = rand() % 3;
        switch (flag)
        {
            case 0:
            ouput[i] = 'A' + rand() % 26;
            break;
            case 1:
            ouput[i] = 'a' + rand() % 26;
            break;
            case 2:
            ouput[i] = '0' + rand() % 10;
            break;
            default:
            ouput[i] = 'x';
            break;
        }
    }
}

