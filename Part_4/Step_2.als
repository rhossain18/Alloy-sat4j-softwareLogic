abstract sig System{
	component : Component,
	delegation : Delegation
}

abstract sig Component {}

abstract sig Socket {
	owner : one Component	
}

abstract sig Ball {
	owner : one Component
}

abstract sig Delegation {
	input : one Socket,
	output : one Ball

}

fact {all s:Socket, b:Ball | s.owner != b.owner}

one sig W1 extends System{}

one sig MainController, Heater extends Component {}

one sig dri extends Socket {}

one sig dpi extends Ball {}

one sig cd extends Delegation {}

fact {dri.owner = MainController and dpi.owner = Heater and cd.input = dri and cd.output = dpi}

pred show []{}

run show
