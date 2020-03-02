package mop;
import java.io.*;
import java.util.*;
import javamoprt.*;
import java.lang.ref.*;
import org.aspectj.lang.*;

class HasNextMonitor_Set extends javamoprt.MOPSet {
	protected HasNextMonitor[] elementData;

	public HasNextMonitor_Set(){
		this.size = 0;
		this.elementData = new HasNextMonitor[4];
	}

	public final int size(){
		while(size > 0 && elementData[size-1].MOP_terminated) {
			elementData[--size] = null;
		}
		return size;
	}

	public final boolean add(MOPMonitor e){
		ensureCapacity();
		elementData[size++] = (HasNextMonitor)e;
		return true;
	}

	public final void endObject(int idnum){
		int numAlive = 0;
		for(int i = 0; i < size; i++){
			HasNextMonitor monitor = elementData[i];
			if(!monitor.MOP_terminated){
				monitor.endObject(idnum);
			}
			if(!monitor.MOP_terminated){
				elementData[numAlive++] = monitor;
			}
		}
		for(int i = numAlive; i < size; i++){
			elementData[i] = null;
		}
		size = numAlive;
	}

	public final boolean alive(){
		for(int i = 0; i < size; i++){
			MOPMonitor monitor = elementData[i];
			if(!monitor.MOP_terminated){
				return true;
			}
		}
		return false;
	}

	public final void endObjectAndClean(int idnum){
		int size = this.size;
		this.size = 0;
		for(int i = size - 1; i >= 0; i--){
			MOPMonitor monitor = elementData[i];
			if(monitor != null && !monitor.MOP_terminated){
				monitor.endObject(idnum);
			}
			elementData[i] = null;
		}
		elementData = null;
	}

	public final void ensureCapacity() {
		int oldCapacity = elementData.length;
		if (size + 1 > oldCapacity) {
			cleanup();
		}
		if (size + 1 > oldCapacity) {
			HasNextMonitor[] oldData = elementData;
			int newCapacity = (oldCapacity * 3) / 2 + 1;
			if (newCapacity < size + 1){
				newCapacity = size + 1;
			}
			elementData = Arrays.copyOf(oldData, newCapacity);
		}
	}

	public final void cleanup() {
		int numAlive = 0 ;
		for(int i = 0; i < size; i++){
			HasNextMonitor monitor = (HasNextMonitor)elementData[i];
			if(!monitor.MOP_terminated){
				elementData[numAlive] = monitor;
				numAlive++;
			}
		}
		for(int i = numAlive; i < size; i++){
			elementData[i] = null;
		}
		size = numAlive;
	}

	public final void event_start(Object t) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			HasNextMonitor monitor = (HasNextMonitor)this.elementData[i];
			if(!monitor.MOP_terminated){
				elementData[numAlive] = monitor;
				numAlive++;

				monitor.Prop_1_event_start(t);
				if(monitor.Prop_1_Category_fail) {
					monitor.Prop_1_handler_fail(t);
				}
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elementData[i] = null;
		}
		size = numAlive;
	}

	public final void event_commit(Object t) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			HasNextMonitor monitor = (HasNextMonitor)this.elementData[i];
			if(!monitor.MOP_terminated){
				elementData[numAlive] = monitor;
				numAlive++;

				monitor.Prop_1_event_commit(t);
				if(monitor.Prop_1_Category_fail) {
					monitor.Prop_1_handler_fail(t);
				}
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elementData[i] = null;
		}
		size = numAlive;
	}

	public final void event_modify(Object t) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			HasNextMonitor monitor = (HasNextMonitor)this.elementData[i];
			if(!monitor.MOP_terminated){
				elementData[numAlive] = monitor;
				numAlive++;

				monitor.Prop_1_event_modify(t);
				if(monitor.Prop_1_Category_fail) {
					monitor.Prop_1_handler_fail(t);
				}
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elementData[i] = null;
		}
		size = numAlive;
	}

	public final void event_rollback(Object t) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			HasNextMonitor monitor = (HasNextMonitor)this.elementData[i];
			if(!monitor.MOP_terminated){
				elementData[numAlive] = monitor;
				numAlive++;

				monitor.Prop_1_event_rollback(t);
				if(monitor.Prop_1_Category_fail) {
					monitor.Prop_1_handler_fail(t);
				}
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elementData[i] = null;
		}
		size = numAlive;
	}
}

class HasNextMonitor extends javamoprt.MOPMonitor implements Cloneable, javamoprt.MOPObject {
	public Object clone() {
		try {
			HasNextMonitor ret = (HasNextMonitor) super.clone();
			return ret;
		}
		catch (CloneNotSupportedException e) {
			throw new InternalError(e.toString());
		}
	}

	int Prop_1_state;
	static final int Prop_1_transition_start[] = {1, 3, 3, 3};;
	static final int Prop_1_transition_commit[] = {3, 0, 0, 3};;
	static final int Prop_1_transition_modify[] = {3, 2, 2, 3};;
	static final int Prop_1_transition_rollback[] = {3, 3, 1, 3};;

	boolean Prop_1_Category_fail = false;

	public HasNextMonitor () {
		Prop_1_state = 0;

	}

	public final void Prop_1_event_start(Object t) {
		MOP_lastevent = 0;

		Prop_1_state = Prop_1_transition_start[Prop_1_state];
		Prop_1_Category_fail = Prop_1_state == 3;
	}

	public final void Prop_1_event_commit(Object t) {
		MOP_lastevent = 1;

		Prop_1_state = Prop_1_transition_commit[Prop_1_state];
		Prop_1_Category_fail = Prop_1_state == 3;
	}

	public final void Prop_1_event_modify(Object t) {
		MOP_lastevent = 2;

		Prop_1_state = Prop_1_transition_modify[Prop_1_state];
		Prop_1_Category_fail = Prop_1_state == 3;
	}

	public final void Prop_1_event_rollback(Object t) {
		MOP_lastevent = 3;

		Prop_1_state = Prop_1_transition_rollback[Prop_1_state];
		Prop_1_Category_fail = Prop_1_state == 3;
	}

	public final void Prop_1_handler_fail (Object t){
		{
			System.err.println("Violation Occured");
			this.reset();
		}

	}

	public final void reset() {
		MOP_lastevent = -1;
		Prop_1_state = 0;
		Prop_1_Category_fail = false;
	}

	public javamoprt.ref.MOPWeakReference MOPRef_t;

	//alive_parameters_0 = [Object t]
	public boolean alive_parameters_0 = true;

	public final void endObject(int idnum){
		switch(idnum){
			case 0:
			alive_parameters_0 = false;
			break;
		}
		switch(MOP_lastevent) {
			case -1:
			return;
			case 0:
			//start
			//alive_t
			if(!(alive_parameters_0)){
				MOP_terminated = true;
				return;
			}
			break;

			case 1:
			//commit
			//alive_t
			if(!(alive_parameters_0)){
				MOP_terminated = true;
				return;
			}
			break;

			case 2:
			//modify
			//alive_t
			if(!(alive_parameters_0)){
				MOP_terminated = true;
				return;
			}
			break;

			case 3:
			//rollback
			//alive_t
			if(!(alive_parameters_0)){
				MOP_terminated = true;
				return;
			}
			break;

		}
		return;
	}

}

public aspect HasNextMonitorAspect implements javamoprt.MOPObject {
	javamoprt.map.MOPMapManager HasNextMapManager;
	public HasNextMonitorAspect(){
		HasNextMapManager = new javamoprt.map.MOPMapManager();
		HasNextMapManager.start();
	}

	// Declarations for the Lock
	static Object HasNext_MOPLock = new Object();

	static boolean HasNext_activated = false;

	// Declarations for Indexing Trees
	static javamoprt.map.MOPBasicRefMapOfMonitor HasNext_t_Map = new javamoprt.map.MOPBasicRefMapOfMonitor(0);
	static javamoprt.ref.MOPWeakReference HasNext_t_Map_cachekey_0 = javamoprt.map.MOPBasicRefMapOfMonitor.NULRef;
	static HasNextMonitor HasNext_t_Map_cachenode = null;

	// Trees for References
	static javamoprt.map.MOPRefMap HasNext_Object_RefMap = HasNext_t_Map;

	pointcut MOP_CommonPointCut() : !within(javamoprt.MOPObject+) && !adviceexecution();
	pointcut HasNext_start(Object t) : (call(* Object.start()) && target(t)) && MOP_CommonPointCut();
	before (Object t) : HasNext_start(t) {
		HasNext_activated = true;
		synchronized(HasNext_MOPLock) {
			HasNextMonitor mainMonitor = null;
			javamoprt.map.MOPMap mainMap = null;
			javamoprt.ref.MOPWeakReference TempRef_t;

			// Cache Retrieval
			if (t == HasNext_t_Map_cachekey_0.get()) {
				TempRef_t = HasNext_t_Map_cachekey_0;

				mainMonitor = HasNext_t_Map_cachenode;
			} else {
				TempRef_t = HasNext_t_Map.getRef(t);
			}

			if (mainMonitor == null) {
				mainMap = HasNext_t_Map;
				mainMonitor = (HasNextMonitor)mainMap.getNode(TempRef_t);

				if (mainMonitor == null) {
					mainMonitor = new HasNextMonitor();

					mainMonitor.MOPRef_t = TempRef_t;

					HasNext_t_Map.putNode(TempRef_t, mainMonitor);
				}

				HasNext_t_Map_cachekey_0 = TempRef_t;
				HasNext_t_Map_cachenode = mainMonitor;
			}

			mainMonitor.Prop_1_event_start(t);
			if(mainMonitor.Prop_1_Category_fail) {
				mainMonitor.Prop_1_handler_fail(t);
			}
		}
	}

	pointcut HasNext_commit(Object t) : (call(* Object.commit()) && target(t)) && MOP_CommonPointCut();
	before (Object t) : HasNext_commit(t) {
		HasNext_activated = true;
		synchronized(HasNext_MOPLock) {
			HasNextMonitor mainMonitor = null;
			javamoprt.map.MOPMap mainMap = null;
			javamoprt.ref.MOPWeakReference TempRef_t;

			// Cache Retrieval
			if (t == HasNext_t_Map_cachekey_0.get()) {
				TempRef_t = HasNext_t_Map_cachekey_0;

				mainMonitor = HasNext_t_Map_cachenode;
			} else {
				TempRef_t = HasNext_t_Map.getRef(t);
			}

			if (mainMonitor == null) {
				mainMap = HasNext_t_Map;
				mainMonitor = (HasNextMonitor)mainMap.getNode(TempRef_t);

				if (mainMonitor == null) {
					mainMonitor = new HasNextMonitor();

					mainMonitor.MOPRef_t = TempRef_t;

					HasNext_t_Map.putNode(TempRef_t, mainMonitor);
				}

				HasNext_t_Map_cachekey_0 = TempRef_t;
				HasNext_t_Map_cachenode = mainMonitor;
			}

			mainMonitor.Prop_1_event_commit(t);
			if(mainMonitor.Prop_1_Category_fail) {
				mainMonitor.Prop_1_handler_fail(t);
			}
		}
	}

	pointcut HasNext_modify(Object t) : (call(* Object.modify()) && target(t)) && MOP_CommonPointCut();
	before (Object t) : HasNext_modify(t) {
		HasNext_activated = true;
		synchronized(HasNext_MOPLock) {
			HasNextMonitor mainMonitor = null;
			javamoprt.map.MOPMap mainMap = null;
			javamoprt.ref.MOPWeakReference TempRef_t;

			// Cache Retrieval
			if (t == HasNext_t_Map_cachekey_0.get()) {
				TempRef_t = HasNext_t_Map_cachekey_0;

				mainMonitor = HasNext_t_Map_cachenode;
			} else {
				TempRef_t = HasNext_t_Map.getRef(t);
			}

			if (mainMonitor == null) {
				mainMap = HasNext_t_Map;
				mainMonitor = (HasNextMonitor)mainMap.getNode(TempRef_t);

				if (mainMonitor == null) {
					mainMonitor = new HasNextMonitor();

					mainMonitor.MOPRef_t = TempRef_t;

					HasNext_t_Map.putNode(TempRef_t, mainMonitor);
				}

				HasNext_t_Map_cachekey_0 = TempRef_t;
				HasNext_t_Map_cachenode = mainMonitor;
			}

			mainMonitor.Prop_1_event_modify(t);
			if(mainMonitor.Prop_1_Category_fail) {
				mainMonitor.Prop_1_handler_fail(t);
			}
		}
	}

	pointcut HasNext_rollback(Object t) : (call(* Object.rollback()) && target(t)) && MOP_CommonPointCut();
	before (Object t) : HasNext_rollback(t) {
		HasNext_activated = true;
		synchronized(HasNext_MOPLock) {
			HasNextMonitor mainMonitor = null;
			javamoprt.map.MOPMap mainMap = null;
			javamoprt.ref.MOPWeakReference TempRef_t;

			// Cache Retrieval
			if (t == HasNext_t_Map_cachekey_0.get()) {
				TempRef_t = HasNext_t_Map_cachekey_0;

				mainMonitor = HasNext_t_Map_cachenode;
			} else {
				TempRef_t = HasNext_t_Map.getRef(t);
			}

			if (mainMonitor == null) {
				mainMap = HasNext_t_Map;
				mainMonitor = (HasNextMonitor)mainMap.getNode(TempRef_t);

				if (mainMonitor == null) {
					mainMonitor = new HasNextMonitor();

					mainMonitor.MOPRef_t = TempRef_t;

					HasNext_t_Map.putNode(TempRef_t, mainMonitor);
				}

				HasNext_t_Map_cachekey_0 = TempRef_t;
				HasNext_t_Map_cachenode = mainMonitor;
			}

			mainMonitor.Prop_1_event_rollback(t);
			if(mainMonitor.Prop_1_Category_fail) {
				mainMonitor.Prop_1_handler_fail(t);
			}
		}
	}

}
