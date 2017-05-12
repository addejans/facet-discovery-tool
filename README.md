# facet-discovery-tool
Machinery to project a system of linear inequalities onto a subspace.

# General structure

## Generator: A tool to generate IP formulation of some global constraints.

This will accept a list of parameters and their domain and a function
to generate the IP formulation.  For each parameter and each value in
their domain, it generates the IP formulation, which is then passed to
the next stage.

For example we could generate two formulations for the `at_least` predicate:
```
at_least(m=[1], n=[3], k=[2,3], l=[4])
```


The variables of the formulations are of two types: those that are
representative of the actual constraint and those that were added in
the translation to the IP formulation. For example in the following
formulation of `at_least(1,3,2,4)`, the xs are real and the ys are
additional:

```
#### at_least_1(x_1,...,x_3) = 2  ; x_i in [0,..,4]
 1y(1,1) +2y(1,2) +3y(1,3) +4y(1,4)-x1 = 0
  y(1,0) + y(1,1) + y(1,2) + y(1,3) + y(1,4) = 1
 1y(2,1) +2y(2,2) +3y(2,3) +4y(2,4)-x2 = 0
  y(2,0) + y(2,1) + y(2,2) + y(2,3) + y(2,4) = 1
 1y(3,1) +2y(3,2) +3y(3,3) +4y(3,4)-x3 = 0
  y(3,0) + y(3,1) + y(3,2) + y(3,3) + y(3,4) = 1
  y(1,2) + y(2,2) + y(3,2) >= 1

0 <= y(i,j) <= 1
```

## Projector: A fast Fourier-Motzkin process.

This accepts the IP formulation generate above and projects onto the
required subspace. For the above example, we would want to project onto
the x space. For the example above, the projection is

```
-1.00000 x1   +1.00000 x2   +1.00000 x3   <= 6.00000 
-1.00000 x1   +1.00000 x2   -1.00000 x3   <= 2.00000 
-1.00000 x1   -1.00000 x2   -1.00000 x3   <= -2.00000 
-1.00000 x1   -1.00000 x2   +1.00000 x3   <= 2.00000 
+1.00000 x1   -1.00000 x2   +1.00000 x3   <= 6.00000 
+1.00000 x1   -1.00000 x2   -1.00000 x3   <= 2.00000 
+1.00000 x1   +1.00000 x2   -1.00000 x3   <= 6.00000 
+1.00000 x1   +1.00000 x2   +1.00000 x3   <= 10.00000 
+1.00000 x1                               <= 4.00000 
-1.00000 x1                               <= 0.00000 
              +1.00000 x2                 <= 4.00000 
              -1.00000 x2                 <= 0.00000 
                            +1.00000 x3   <= 4.00000 
                            -1.00000 x3   <= 0.00000 
```

## Abstractor: An abstractor of facets.

After projection onto the appropriate space, we have a set of linear
inequalities. We need to abstract this set.  This means identify the coefficients and the corresponding right hand side for a family of formulations.

The output of this phase will be of the form of a set of constants,
with their values and the parameters that produced them.  For the same
example the abstraction would isolate a number of facets of the form:
```
c1 x1 + c2 x2 + c3 x3 <= R1
```
It would then generate, for each constant a list of the form (value, parameters)*
```
c1 (v11, m1, n1, k1, l1) (v12, m2, k2, l2) ...
c2 (v21, m1, n1, k1, l1) (v22, m2, k2, l2) ...
```

## Discoverer: A function discoverer.

From the list of constants the discoverer finds the functions that,
from the parameters, determine the constants.  That is `ci =
fi(m,n,k,l)`.  We can then substitute these function in the abstract
formulation of the facets detected by the abstractor and we have the
facet of the polytope of the global constraint.

## Stages of development

In increasing order of difficulty:

- Generator 
- Projector 
- Discoveror
- Abstractor

The two easier elements are the generator and the projector. We will
start with those. 