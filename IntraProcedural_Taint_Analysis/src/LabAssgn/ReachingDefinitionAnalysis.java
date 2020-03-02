package LabAssgn;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Iterator;
import java.util.List;
import soot.Value;

import soot.toolkits.graph.UnitGraph;
import soot.Body;
import soot.Local;
import soot.Unit;
import soot.ValueBox;
import soot.jimple.AssignStmt;
import soot.jimple.Constant;
import soot.jimple.IdentityStmt;
import soot.jimple.InvokeStmt;
import soot.jimple.ReturnStmt;
import soot.jimple.Stmt;
import soot.tagkit.LineNumberTag;
import soot.toolkits.graph.ExceptionalUnitGraph;
import soot.toolkits.graph.UnitGraph;

import soot.toolkits.scalar.FlowSet;
import soot.toolkits.scalar.AbstractFlowSet;
import soot.toolkits.scalar.ArraySparseSet;
import soot.toolkits.scalar.BackwardFlowAnalysis;
import soot.toolkits.scalar.ForwardFlowAnalysis;
import soot.toolkits.scalar.Pair;
import soot.util.Chain;

public class ReachingDefinitionAnalysis extends BackwardFlowAnalysis {

	Body b;
	FlowSet inval, outval;

	public ReachingDefinitionAnalysis(UnitGraph g) {
		super(g);
		b = g.getBody();
		doAnalysis();
	}

	@Override
	protected void flowThrough(Object in, Object unit, Object out) 
	{
		outval = (FlowSet) in;
		inval = (FlowSet) out;
		Stmt u = (Stmt) unit;
		outval.copy(inval);
		String var;
		LineNumberTag tag = (LineNumberTag) u.getTag("LineNumberTag");
		
		if (u instanceof ReturnStmt || u.toString().contains("PrintStream")) {
//			System.out.println(u.toString());
//			System.out.println("dsss");
			System.out.println(u.getUseBoxes().toString());
			for (ValueBox gft : u.getUseBoxes()) {
				if(gft.getValue() instanceof Local) {
					inval.add(gft.getValue().toString());
				}

			}

		}

		if (u instanceof AssignStmt) {
			if(((AssignStmt) u).getRightOp() instanceof Constant) 
			{
				for(ValueBox hft: u.getDefBoxes()) {
					inval.remove(hft.getValue().toString());
				}
				
				
			
			}
			for(ValueBox hft: u.getDefBoxes()) 
			{
				if(outval.contains(hft.getValue().toString())) 
				{
					for(ValueBox ift: u.getUseBoxes() ) {
						if(ift.getValue() instanceof Local) {
							inval.add(ift.getValue().toString());
						}
						
						
					}
					
					
					
				}
			}
			
			
		}
		System.out.println("In :"+inval.toString());
		System.out.println("Unit : " +u.toString());
		System.out.println("Out :"+outval.toString());
		System.out.println("*************************************");
	}

	@Override
	protected void copy(Object source, Object dest) {
		FlowSet srcSet = (FlowSet) source;
		FlowSet destSet = (FlowSet) dest;
		srcSet.copy(destSet);
	}

	// Setting the entry set for BInit
	@Override
	protected Object entryInitialFlow() {
		ArraySparseSet as = new ArraySparseSet();
//		Chain<Local> locals = this.b.getMethod().getActiveBody().getLocals(); // Collecting all locals i the current
//																				// method
//		Iterator<Local> i2 = locals.iterator();
//		while (i2.hasNext()) {
//			Local ll = i2.next();
//			String name = ll.getName();
//			if (!((name.equals("this")) || (name.charAt(0) == '$'))) // Filtering the intermediate variables created b
//																		// Soot
//			{
//				Pair<String, String> p = new Pair<String, String>(name, "?"); // To retain more information you may use
//																				// <Local,String>
//				as.add(p);
//				System.out.println("Adding in entryInitial flow: " + p);
//			}
//		}
		return as;
	}

	@Override
	protected void merge(Object in1, Object in2, Object out) {
		FlowSet inval1 = (FlowSet) in1;
		FlowSet inval2 = (FlowSet) in2;
		FlowSet outVal = (FlowSet) out;
		inval1.union(inval2, outVal); // Merging in may analysis

	}

	@Override
	protected Object newInitialFlow() // Initializing entryy set of each statement
	{
		ArraySparseSet as = new ArraySparseSet();
		return as;
	}

}