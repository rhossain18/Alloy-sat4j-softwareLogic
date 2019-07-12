/*
Exercise from Huth&Ryan LICS2, section 2.7.5, p167
*/
module KripkeModel

sig Prop{}

sig Test extends Prop{}

sig State{}

one sig StateMachine{
    states : set State,
    prop : State -> Prop,
    next    : State -> State,
    init : set State,
    final : set State
}{
#init != 0
all s:State | s in states
all f:final | all s:State| f->s not in next
}

pred Reaches[m : StateMachine, s : State]{
    all i : m.init | i->s in *(m.next)
}

pred DeadLock[m : StateMachine, s : State]{
    no n : State | s->n in m.next
}

pred DeadLockFree[m : StateMachine]{
    all f : State | (Reaches[m,f] and DeadLock[m,f]) => (f in m.final)
}

pred Deterministic[m : StateMachine]{
    all f:State | lone n:State | Reaches[m,f] => f->n in m.next
}

pred Reachability[m : StateMachine, p : Prop]{
    some s:State | s->p in m.prop and Reaches[m,s]
}

pred Liveness[m : StateMachine, p : Prop]{
    all s : State | some sp : State | s->sp in *(m.next) and sp->p in m.prop
}

pred Implies[m : StateMachine, p : Prop]{
    Liveness[m,p] => Reachability[m,p]
}

pred Converse[m : StateMachine, p : Prop]{
     Reachability[m,p] => Liveness[m,p]
}

pred F[m : StateMachine]{
    #Prop = 2
    #State = 3
    DeadLockFree[m]
    some s,s1,s2:State | s->s1 in m.next and s->s2 in m.next and s1!=s2
    all s1,s2:State, p:Prop | s1->p in m.prop and s2->p in m.prop => s1 = s2
}

assert noDeadLock{DeadLockFree[StateMachine]}

assert Deterministic{Deterministic[StateMachine]}

assert Implies{Implies[StateMachine, Test]}

assert Converse{Converse[StateMachine, Test]}

fact{F[StateMachine]}

pred show{}

run Implies
