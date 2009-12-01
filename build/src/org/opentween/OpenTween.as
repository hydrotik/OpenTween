/**
 * Copyright (c) 2009 Donovan Adams, http://blog.hydrotik.com - donovan (at) hydrotik (dot) com
 * Copyright (c) 2008 Donovan Adams, http://blog.hydrotik.com - donovan (at) hydrotik (dot) com
 * Copyright (c) 2007 Moses Gunesch, http://www.goasap.org
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
 
package org.opentween {
	import org.goasap.GoEngine;
	import org.goasap.events.GoEvent;
	import org.goasap.interfaces.IManager;
	import org.goasap.interfaces.IPlayable;
	import org.goasap.items.LinearGo;
	import org.goasap.managers.LinearGoRepeater;
	import org.goasap.managers.OverlapMonitor;
	import org.goasap.utils.PlayableGroup;
	import org.opentween.core.ITweenableProperty;

	import flash.utils.Dictionary;

	public class OpenTween extends LinearGo {

		public static var VERBOSE : Boolean = true;

		public static var PULSE : Number = -1;

		// CONSTANTS
		
		public static const VERSION:String = "OpenTween 0.1.0";
		
		public static const GO_VERSION:String = "0.5.1e";

		public static const INFO:String = VERSION + " (c) Donovan Adams, MIT Licensed.";
		
		protected static var debug : Function;
		
		// PRIVATE CLASS VARS
		
		protected static var _propertyList: Dictionary = new Dictionary(false);
		
		protected static var _targList: Dictionary = new Dictionary(true);
		
		protected static var _init : Boolean = false;

		protected var _target : Object;
		
		protected var _closure : Function;
		
		protected var _update : Function;
		
		protected var _tweenStartProps : Dictionary = new Dictionary(true);
		
		protected var _tweenList: Dictionary = new Dictionary(true);
		
		protected var _propsTo : Object;
		
		protected var _updateArgs : Array;
		
		protected var _closureArgs : Array;
		
		protected var _scope : *; 
		
		protected var _propInitialized:Boolean = false;
		
		protected static var _OverlapMonitor : IManager;
		
		
		/**
		 * OpenTween
		 *
		 * @author: Donovan Adams, E-Mail: donovan[(replace at)]hydrotik.com, url: http://blog.hydrotik.com/
		 * @author: Moses Gunesch, http://www.goasap.org
		 * @version: 0.1.0
		 *
		 * @description OpenTween is an open source tweening system that runs on the Go animation engine. Uses an MIT license, is designed to be scalable and modular, can even be used to create a "private label" entry point that can be packaged with other development projects
		 *
		 * @history 0.1.0 - Pieced and re-written from the HydroTween project and moved to Github
		 *
		 * @example Go to <a href="http://github.com/hydrotik/OpenTween" target="blank">OpenTween Guide on Github</a> for more usage info. 
		 */  
		
		public static function init():void{
			if (_init) { return; }
			_init = true;
			debug = trace;
			if (!GoEngine.getManager("OverlapMonitor")){
				_OverlapMonitor = new OverlapMonitor();
				GoEngine.addManager(_OverlapMonitor);
			}
			if(VERBOSE) debug("\n\t*****************************\n\tVERSION: " + VERSION + " - Go Version: "+GoEngine.INFO + "\n\t*****************************\n\n");
			
			for (var i : int = 0; i < PropertyList.PROPERTIES.length; i++) PropertyList.PROPERTIES[i].addProperties();
		}
		
		public static function setPulse(p:Number):void{
			PULSE = p;
		}
		
		public static function isTweening(target:Object):Boolean {
        	for (var targ:Object in _targList) {
        		if(targ == target) return true;
        	}
             return false;
        }
        	
		public static function addProperties(key:String, property:String, propertyClass:Class):void {
             if (!  _propertyList.hasOwnProperty(key))
                  _propertyList[key] = {prop:property, propertyClass:propertyClass};
        }
        
        public static function getProperties(key:String):Class {
			return _propertyList[key].propertyClass;
        }

		public static function go(target : Object,
					propsTo : Object = null,
					duration : Number = NaN,
					delay : Number = NaN,
					easing : Function = null,
					closure : Function = null,
					update : Function = null,
					closureArgs:Array = null,
					updateArgs:Array = null,
					extraEasingParams : Array = null,
					repeater : Object=null,
					autoGC : Boolean=true,
					useRelative : Boolean = false,
					useRounding : Boolean = false
		) : IPlayable {
			if (target==null) { return null; }
			var isGroup:Boolean = target is Array;
			var go:IPlayable = (isGroup ? new PlayableGroup() : null);
			var targArray:Array = (isGroup ? target as Array : [target]);
			var i:int = 0;
			for each (var targ:Object in targArray) {
				var tween: OpenTween = new OpenTween(
										targ,
										propsTo,
										duration,
										delay,
										easing,
										(i == targArray.length - 1) ? closure : null,
										(i == targArray.length - 1) ? update : null,
										(i == targArray.length - 1) ? closureArgs : null,
										(i == targArray.length - 1) ? updateArgs : null,
										extraEasingParams,
										repeater,
										autoGC,
										useRelative,
										useRounding,
										OpenTween.PULSE
				);
				if (isGroup) (go as PlayableGroup).addChild(tween); else go = tween;
				i++;
			}
			go.start();
			return go;
		}
		
		public function OpenTween(
					target : Object = null,
					propsTo : Object = null,
					duration : Number = NaN,
					delay : Number = NaN,
					easing : Function = null,
					closure : Function = null,
					update : Function = null,
					closureArgs:Array = null,
					updateArgs:Array = null,
					extraEasingParams : Array = null,
					repeater : Object=null,
					autoGC:Boolean = true,
					useRelative : Boolean = false,
					useRounding : Boolean = false,
					pulseInterval : Number = NaN
			) {
			super(delay, duration, easing, extraEasingParams, (repeater == null) ? null : ((repeater is LinearGoRepeater) ? repeater as LinearGoRepeater : new LinearGoRepeater(repeater.cycles, repeater.reverse, repeater.easing)), useRelative, useRounding, useFrames, pulseInterval);
			init();
			_update = update;
			_updateArgs = updateArgs;
			_target = target;
			if(autoGC) addCallback(dispose);
			_closure = closure;
			_closureArgs = closureArgs;
			if(propsTo) setProps(propsTo);
		}
		
		/*
		 **************************************************************************************
		 * 
		 * 		SET PROPS
		 */
		
		public function setProps(propsTo:Object):void {
			_propsTo = propsTo;
		}
		
		protected function propInit():Boolean {
			//var key:String;
			for (var key:String in _propsTo) {
				//var isStartProp:Boolean = prop.indexOf("start_")==0;
				//key = (isStartProp ? prop.slice(6) : prop);
				if (_propertyList.hasOwnProperty(key)) {
					_tweenList[key] = new (_propertyList[key].propertyClass)() as ITweenableProperty;
					//if(isStartProp) _tweenList[key].start = _propsTo[key];
					_tweenList[key].end = _propsTo[key];
					_tweenList[key].prop = _propertyList[key].prop;
					trace(key);
				}
			}
			
			if (!_target) return false;
			
			for (key in _tweenList){
					var item:ITweenableProperty = _tweenList[key] as ITweenableProperty;
					item.read(_target);
					item.difference(useRelative);
			}
			_propInitialized = true;
			return true;
		}
		
		
		
		/*
		 ***************************************************************************************
		 * 
		 * 		START
		 */
		override public function start():Boolean {
			//_propsTo = null;
			if (!propInit()) return false;
			_targList[_target] = _target;
			return (super.start());
		}
		
		
		
		/*
		 ***************************************************************************************
		 * 
		 * 		UPDATE
		 */
		override protected function onUpdate(type : String) : void {
			for (var key:String in _tweenList) ITweenableProperty(_tweenList[key]).write(_target, super.correctValue(_position));
			if(_update != null) _update.apply(_scope, _updateArgs);
			if(type == GoEvent.COMPLETE) if(_closure != null) _closure.apply((_scope != null)?  _scope: null, (_closureArgs != null) ?  _closureArgs : null);
		}
		
		/*
		 ***************************************************************************************
		 * 
		 * 		UTILS
		 */
		
		public static function getVersion():String{
			return VERSION;	
		}

		public static function getPropertyList():void{
			for (var key:String in _propertyList) if(VERBOSE) debug(key);
		}
		
		protected function dispose():void{
			_targList[_target] = null;
			delete _targList[_target];
			for (var prop:String in _propsTo) {
				_propsTo[prop] = null;
				_tweenList[prop] = null;
			}
			_target = null;
			_propsTo = null;
			_tweenList = null;
			_closure = null;
			_update = null;
			_closureArgs = null;
			_updateArgs = null;
			_scope = null;
			_tweenStartProps = null;
		}
		
		public function setTarget(target : Object):void {
			_target = target;
		}
		
		public function setClosure(closure : Function):void {
			_closure = closure;
		}
		
		public function setClosureArgs(args:Array):void {
			_closureArgs = args;
		}
		
		public function setUpdate(update : Function):void {
			_update = update;
		}
		
		public function setUpdateArgs(args:Array):void {
			_updateArgs = args;
		}
		public function setScope(scope:*):void {
			_scope = scope;
		}
		
		
		/*
		 ***************************************************************************************
		 ***************************************************************************************
		 ***************************************************************************************
		 */
		 // -== Imanageable Implementation ==-
		
		public function getActiveTargets() : Array {
			return [_target];
		}
		
		public function getActiveProperties() : Array {
			var a : Array = new Array();
			for (var prop : String in _tweenList) a.push(prop);
			return a;
		}
		
		public function isHandling(properties : Array) : Boolean {
			for (var prop : String in _tweenList) { 
				if (!isNaN(_tweenList[prop].end)) {
					if (properties.indexOf(prop) > -1) return true;
				}
			}
			return false;
		}
		
		public function releaseHandling(...params) : void {
			super.stop();
		}
		
	}
}
