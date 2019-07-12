sig System{
	components : Component,
	delegations : Delegation
}

sig Component {
}

sig Socket {
	owner : one Component	
}

sig Ball {
	owner : one Component
}

sig Delegation {
	input : one Socket,
	output : one Ball

}

fact {all s:Socket, b:Ball | s.owner != b.owner}

pred show {}

run show
