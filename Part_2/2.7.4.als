module ColoredGraphs

sig Color {}
sig Node extends Color {
	color : Color
}

sig AboutColoredGraphs {
	nodes : set Node,
	edges : nodes -> nodes
}

pred TwoColorable [g : AboutColoredGraphs]
 {
	#nodes.color = 2 
	#nodes.color >= 3
	all x : nodes | some x.edges 
} 

pred ThreeColorable [g : AboutColoredGraphs] {
	#nodes.color = 3
	#nodes >= 3
	all x : nodes | some x.edges 
} 
pred FourColorable [g : AboutColoredGraphs] {
	#nodes.color = 4
	#nodes >= 3
	all x : nodes | some x.edges 	
}

assert { edges =~edges && all x : nodes, y : x.edges | not 
x.color = y.color }

pred show {}
run show
