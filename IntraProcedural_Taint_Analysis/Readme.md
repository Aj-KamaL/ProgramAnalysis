Taint analysis is a popular method to find out which sinks are affected by these inputs. It can locate the variables that can be controlled by the user, tracing the propagation of the taint, assuming user input as tainted.

Intraprocedural taint variable analysis traverses and analyzes a given program in a backward direction to find out which variables are affecting the sinks. 

Consider return and print statements as sinks here.

Example:


Input
int bar1(int x) {
int product, a;
a = 10;
product = x * a;
return product;
}



Output:
In: {}
Unit: return product
Out :{product}
In: {product}
Unit: product = x * a
Out :{product, x, a}
In: {product, x, a}
Unit: a = 10
Out :{product, x}
In: {product, x}
Unit: x := @parameter0: int
Out :{product, x}