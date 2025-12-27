#include <stdio.h>
#include <string.h>

int main(void)
{
  printf("Hello World! from docker container\n");

  char *s1 = "123";
  char *s2 = "123";

  printf("is two string equal: %d\n", strcmp(s1, s2));
  return 0;
}
