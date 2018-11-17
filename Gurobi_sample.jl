using JuMP
import Gurobi

M = 6
N = 3

# Build model indication, and set the solver.
m = Model(solver = Gurobi.GurobiSolver(Method=2))

# Set Variables
@variable(m, x[1:N] >= 0)
@variable(m, y[1:M] >= 0)

# Set Parameters
Xind = [1 2 3]
yind = [2 3 4 5 6 7]

# define objective
@objective(m, Min,(Xind * x + yind * y)[1])

Xind1 = [2 -1 5]
Yind1 = [9 2 -3 1 -7 12]

@constraint(m, (Xind1 * x + Yind1 * y)[1] <= 6)

Yind2 = [9 8 7 9 7 6]

Xind2 = [3 2 1; 2 5 7; 9 -1 4]
Zind2 = [4 3 2]'

@constraint(m, Xind2 * x .>= Zind2)

status = solve(m)

print(getvalue(x))
print(getvalue(y))
