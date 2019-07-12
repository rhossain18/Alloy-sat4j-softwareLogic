abstract sig System{
    components : set Component,
    delegations : set Delegation
}

abstract sig Component {}

abstract sig Socket{
    owner: one Component
}

abstract sig Ball{
    owner : one Component
}

abstract sig Delegation{
    input : one Socket,
    output : one Ball
}

abstract sig Feature{}

lone sig Delay,Heat,Dry extends Feature{}

fact {all d:Delegation | some s:System | d in s.delegations}

fact{all c:Component | some s:System | c in s.components}

fact noSelfDelegation {all  d:Delegation | d.input.owner != d.output.owner}

one sig W extends System{}

one sig MainController extends Component{}

one sig tri,hri,dri extends Socket{}

fact{tri.owner = MainController and hri.owner = MainController and dri.owner = MainController }

fact{tdri.owner = Dryer}

lone sig tdri extends Socket{}

lone sig cd,ch,ct,dt extends Delegation{}

lone sig dpi,hpi,tpi,tdpi extends Ball{}

lone sig Heater,Timer,Dryer extends Component{}

fact{ dpi.owner = Heater}
fact{#cd>0 => cd.input = dri and cd.output = dpi}

fact{tpi.owner = Timer}
fact{#ct>0 => (ct.input = tri and ct.output = tpi)}

fact{tdpi.owner = Timer}
fact{#dt>0 => (dt.input = tdri and dt.output = tdpi)}

fact{ hpi.owner = Dryer }
fact{#ch>0 => (ch.input = hri and ch.output = hpi)}

fact{#Heat = #cd}
fact{#Dry = #ch}
fact{#Delay = #ct}
fact{#Dry = #dt}

fact{#Heater = #Heat and #Dryer = #Dry and (#Timer=1) <=> {#Delay = 1 or #Dry = 1}}


fact{(#Heat = 1 implies #Delay = 0) and (#Delay = 1 implies #Heat = 0)}

fact{#Heat = 0 and #Dry = 1}

pred show[]{}

run show
