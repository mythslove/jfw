﻿package com.jfw.engine.core.geom.isolib.map.consts
{
	
	/**
	 * 数学常量表
	 * 用于性能优化，把耗时的计算优先计算放入常量表，提高访问速度
	 * 
	 */
	public class MathConst 
	{
		/**
		 *角度转换成弧度 常数
		 */		
		public static const DEGREE_TO_RADIANS: Number = Math.PI/180;
		/**
		 * 弧度转换成角度 常数
		 * 
		 */
		public static const RADIANS_TO_DEGREE: Number = 180 / Math.PI;
		
		/**
		 *角度的sin值，从（-180度~~180度） 
		 */		
		public static var SIN: Array = [Math.sin(-180*DEGREE_TO_RADIANS),
Math.sin(-179*DEGREE_TO_RADIANS),Math.sin(-178*DEGREE_TO_RADIANS),Math.sin(-177*DEGREE_TO_RADIANS),Math.sin(-176*DEGREE_TO_RADIANS),Math.sin(-175*DEGREE_TO_RADIANS),Math.sin(-174*DEGREE_TO_RADIANS),
Math.sin(-173*DEGREE_TO_RADIANS),Math.sin(-172*DEGREE_TO_RADIANS),Math.sin(-171*DEGREE_TO_RADIANS),Math.sin(-170*DEGREE_TO_RADIANS),Math.sin(-169*DEGREE_TO_RADIANS),Math.sin(-168*DEGREE_TO_RADIANS),
Math.sin(-167*DEGREE_TO_RADIANS),Math.sin(-166*DEGREE_TO_RADIANS),Math.sin(-165*DEGREE_TO_RADIANS),Math.sin(-164*DEGREE_TO_RADIANS),Math.sin(-163*DEGREE_TO_RADIANS),Math.sin(-162*DEGREE_TO_RADIANS),
Math.sin(-161*DEGREE_TO_RADIANS),Math.sin(-160*DEGREE_TO_RADIANS),Math.sin(-159*DEGREE_TO_RADIANS),Math.sin(-158*DEGREE_TO_RADIANS),Math.sin(-157*DEGREE_TO_RADIANS),Math.sin(-156*DEGREE_TO_RADIANS),
Math.sin(-155*DEGREE_TO_RADIANS),Math.sin(-154*DEGREE_TO_RADIANS),Math.sin(-153*DEGREE_TO_RADIANS),Math.sin(-152*DEGREE_TO_RADIANS),Math.sin(-151*DEGREE_TO_RADIANS),Math.sin(-150*DEGREE_TO_RADIANS),
Math.sin(-149*DEGREE_TO_RADIANS),Math.sin(-148*DEGREE_TO_RADIANS),Math.sin(-147*DEGREE_TO_RADIANS),Math.sin(-146*DEGREE_TO_RADIANS),Math.sin(-145*DEGREE_TO_RADIANS),Math.sin(-144*DEGREE_TO_RADIANS),
Math.sin(-143*DEGREE_TO_RADIANS),Math.sin(-142*DEGREE_TO_RADIANS),Math.sin(-141*DEGREE_TO_RADIANS),Math.sin(-140*DEGREE_TO_RADIANS),Math.sin(-139*DEGREE_TO_RADIANS),Math.sin(-138*DEGREE_TO_RADIANS),
Math.sin(-137*DEGREE_TO_RADIANS),Math.sin(-136*DEGREE_TO_RADIANS),Math.sin(-135*DEGREE_TO_RADIANS),Math.sin(-134*DEGREE_TO_RADIANS),Math.sin(-133*DEGREE_TO_RADIANS),Math.sin(-132*DEGREE_TO_RADIANS),
Math.sin(-131*DEGREE_TO_RADIANS),Math.sin(-130*DEGREE_TO_RADIANS),Math.sin(-129*DEGREE_TO_RADIANS),Math.sin(-128*DEGREE_TO_RADIANS),Math.sin(-127*DEGREE_TO_RADIANS),Math.sin(-126*DEGREE_TO_RADIANS),
Math.sin(-125*DEGREE_TO_RADIANS),Math.sin(-124*DEGREE_TO_RADIANS),Math.sin(-123*DEGREE_TO_RADIANS),Math.sin(-122*DEGREE_TO_RADIANS),Math.sin(-121*DEGREE_TO_RADIANS),Math.sin(-120*DEGREE_TO_RADIANS),
Math.sin(-119*DEGREE_TO_RADIANS),Math.sin(-118*DEGREE_TO_RADIANS),Math.sin(-117*DEGREE_TO_RADIANS),Math.sin(-116*DEGREE_TO_RADIANS),Math.sin(-115*DEGREE_TO_RADIANS),Math.sin(-114*DEGREE_TO_RADIANS),
Math.sin(-113*DEGREE_TO_RADIANS),Math.sin(-112*DEGREE_TO_RADIANS),Math.sin(-111*DEGREE_TO_RADIANS),Math.sin(-110*DEGREE_TO_RADIANS),Math.sin(-109*DEGREE_TO_RADIANS),Math.sin(-108*DEGREE_TO_RADIANS),
Math.sin(-107*DEGREE_TO_RADIANS),Math.sin(-106*DEGREE_TO_RADIANS),Math.sin(-105*DEGREE_TO_RADIANS),Math.sin(-104*DEGREE_TO_RADIANS),Math.sin(-103*DEGREE_TO_RADIANS),Math.sin(-102*DEGREE_TO_RADIANS),
Math.sin(-101*DEGREE_TO_RADIANS),Math.sin(-100*DEGREE_TO_RADIANS),Math.sin(-99*DEGREE_TO_RADIANS),Math.sin(-98*DEGREE_TO_RADIANS),Math.sin(-97*DEGREE_TO_RADIANS),Math.sin(-96*DEGREE_TO_RADIANS),
Math.sin(-95*DEGREE_TO_RADIANS),Math.sin(-94*DEGREE_TO_RADIANS),Math.sin(-93*DEGREE_TO_RADIANS),Math.sin(-92*DEGREE_TO_RADIANS),Math.sin(-91*DEGREE_TO_RADIANS),Math.sin(-90*DEGREE_TO_RADIANS),
Math.sin(-89*DEGREE_TO_RADIANS),Math.sin(-88*DEGREE_TO_RADIANS),Math.sin(-87*DEGREE_TO_RADIANS),Math.sin(-86*DEGREE_TO_RADIANS),Math.sin(-85*DEGREE_TO_RADIANS),Math.sin(-84*DEGREE_TO_RADIANS),
Math.sin(-83*DEGREE_TO_RADIANS),Math.sin(-82*DEGREE_TO_RADIANS),Math.sin(-81*DEGREE_TO_RADIANS),Math.sin(-80*DEGREE_TO_RADIANS),Math.sin(-79*DEGREE_TO_RADIANS),Math.sin(-78*DEGREE_TO_RADIANS),
Math.sin(-77*DEGREE_TO_RADIANS),Math.sin(-76*DEGREE_TO_RADIANS),Math.sin(-75*DEGREE_TO_RADIANS),Math.sin(-74*DEGREE_TO_RADIANS),Math.sin(-73*DEGREE_TO_RADIANS),Math.sin(-72*DEGREE_TO_RADIANS),
Math.sin(-71*DEGREE_TO_RADIANS),Math.sin(-70*DEGREE_TO_RADIANS),Math.sin(-69*DEGREE_TO_RADIANS),Math.sin(-68*DEGREE_TO_RADIANS),Math.sin(-67*DEGREE_TO_RADIANS),Math.sin(-66*DEGREE_TO_RADIANS),
Math.sin(-65*DEGREE_TO_RADIANS),Math.sin(-64*DEGREE_TO_RADIANS),Math.sin(-63*DEGREE_TO_RADIANS),Math.sin(-62*DEGREE_TO_RADIANS),Math.sin(-61*DEGREE_TO_RADIANS),Math.sin(-60*DEGREE_TO_RADIANS),
Math.sin(-59*DEGREE_TO_RADIANS),Math.sin(-58*DEGREE_TO_RADIANS),Math.sin(-57*DEGREE_TO_RADIANS),Math.sin(-56*DEGREE_TO_RADIANS),Math.sin(-55*DEGREE_TO_RADIANS),Math.sin(-54*DEGREE_TO_RADIANS),
Math.sin(-53*DEGREE_TO_RADIANS),Math.sin(-52*DEGREE_TO_RADIANS),Math.sin(-51*DEGREE_TO_RADIANS),Math.sin(-50*DEGREE_TO_RADIANS),Math.sin(-49*DEGREE_TO_RADIANS),Math.sin(-48*DEGREE_TO_RADIANS),
Math.sin(-47*DEGREE_TO_RADIANS),Math.sin(-46*DEGREE_TO_RADIANS),Math.sin(-45*DEGREE_TO_RADIANS),Math.sin(-44*DEGREE_TO_RADIANS),Math.sin(-43*DEGREE_TO_RADIANS),Math.sin(-42*DEGREE_TO_RADIANS),
Math.sin(-41*DEGREE_TO_RADIANS),Math.sin(-40*DEGREE_TO_RADIANS),Math.sin(-39*DEGREE_TO_RADIANS),Math.sin(-38*DEGREE_TO_RADIANS),Math.sin(-37*DEGREE_TO_RADIANS),Math.sin(-36*DEGREE_TO_RADIANS),
Math.sin(-35*DEGREE_TO_RADIANS),Math.sin(-34*DEGREE_TO_RADIANS),Math.sin(-33*DEGREE_TO_RADIANS),Math.sin(-32*DEGREE_TO_RADIANS),Math.sin(-31*DEGREE_TO_RADIANS),Math.sin(-30*DEGREE_TO_RADIANS),
Math.sin(-29*DEGREE_TO_RADIANS),Math.sin(-28*DEGREE_TO_RADIANS),Math.sin(-27*DEGREE_TO_RADIANS),Math.sin(-26*DEGREE_TO_RADIANS),Math.sin(-25*DEGREE_TO_RADIANS),Math.sin(-24*DEGREE_TO_RADIANS),
Math.sin(-23*DEGREE_TO_RADIANS),Math.sin(-22*DEGREE_TO_RADIANS),Math.sin(-21*DEGREE_TO_RADIANS),Math.sin(-20*DEGREE_TO_RADIANS),Math.sin(-19*DEGREE_TO_RADIANS),Math.sin(-18*DEGREE_TO_RADIANS),
Math.sin(-17*DEGREE_TO_RADIANS),Math.sin(-16*DEGREE_TO_RADIANS),Math.sin(-15*DEGREE_TO_RADIANS),Math.sin(-14*DEGREE_TO_RADIANS),Math.sin(-13*DEGREE_TO_RADIANS),Math.sin(-12*DEGREE_TO_RADIANS),
Math.sin(-11*DEGREE_TO_RADIANS),Math.sin(-10*DEGREE_TO_RADIANS),Math.sin(-9*DEGREE_TO_RADIANS),Math.sin(-8*DEGREE_TO_RADIANS),Math.sin(-7*DEGREE_TO_RADIANS),Math.sin(-6*DEGREE_TO_RADIANS),
Math.sin(-5*DEGREE_TO_RADIANS),Math.sin(-4*DEGREE_TO_RADIANS),Math.sin(-3*DEGREE_TO_RADIANS),Math.sin(-2*DEGREE_TO_RADIANS),Math.sin(-1*DEGREE_TO_RADIANS),Math.sin(0*DEGREE_TO_RADIANS),
Math.sin(1*DEGREE_TO_RADIANS),Math.sin(2*DEGREE_TO_RADIANS),Math.sin(3*DEGREE_TO_RADIANS),Math.sin(4*DEGREE_TO_RADIANS),Math.sin(5*DEGREE_TO_RADIANS),Math.sin(6*DEGREE_TO_RADIANS),
Math.sin(7*DEGREE_TO_RADIANS),Math.sin(8*DEGREE_TO_RADIANS),Math.sin(9*DEGREE_TO_RADIANS),Math.sin(10*DEGREE_TO_RADIANS),Math.sin(11*DEGREE_TO_RADIANS),Math.sin(12*DEGREE_TO_RADIANS),
Math.sin(13*DEGREE_TO_RADIANS),Math.sin(14*DEGREE_TO_RADIANS),Math.sin(15*DEGREE_TO_RADIANS),Math.sin(16*DEGREE_TO_RADIANS),Math.sin(17*DEGREE_TO_RADIANS),Math.sin(18*DEGREE_TO_RADIANS),
Math.sin(19*DEGREE_TO_RADIANS),Math.sin(20*DEGREE_TO_RADIANS),Math.sin(21*DEGREE_TO_RADIANS),Math.sin(22*DEGREE_TO_RADIANS),Math.sin(23*DEGREE_TO_RADIANS),Math.sin(24*DEGREE_TO_RADIANS),
Math.sin(25*DEGREE_TO_RADIANS),Math.sin(26*DEGREE_TO_RADIANS),Math.sin(27*DEGREE_TO_RADIANS),Math.sin(28*DEGREE_TO_RADIANS),Math.sin(29*DEGREE_TO_RADIANS),Math.sin(30*DEGREE_TO_RADIANS),
Math.sin(31*DEGREE_TO_RADIANS),Math.sin(32*DEGREE_TO_RADIANS),Math.sin(33*DEGREE_TO_RADIANS),Math.sin(34*DEGREE_TO_RADIANS),Math.sin(35*DEGREE_TO_RADIANS),Math.sin(36*DEGREE_TO_RADIANS),
Math.sin(37*DEGREE_TO_RADIANS),Math.sin(38*DEGREE_TO_RADIANS),Math.sin(39*DEGREE_TO_RADIANS),Math.sin(40*DEGREE_TO_RADIANS),Math.sin(41*DEGREE_TO_RADIANS),Math.sin(42*DEGREE_TO_RADIANS),
Math.sin(43*DEGREE_TO_RADIANS),Math.sin(44*DEGREE_TO_RADIANS),Math.sin(45*DEGREE_TO_RADIANS),Math.sin(46*DEGREE_TO_RADIANS),Math.sin(47*DEGREE_TO_RADIANS),Math.sin(48*DEGREE_TO_RADIANS),
Math.sin(49*DEGREE_TO_RADIANS),Math.sin(50*DEGREE_TO_RADIANS),Math.sin(51*DEGREE_TO_RADIANS),Math.sin(52*DEGREE_TO_RADIANS),Math.sin(53*DEGREE_TO_RADIANS),Math.sin(54*DEGREE_TO_RADIANS),
Math.sin(55*DEGREE_TO_RADIANS),Math.sin(56*DEGREE_TO_RADIANS),Math.sin(57*DEGREE_TO_RADIANS),Math.sin(58*DEGREE_TO_RADIANS),Math.sin(59*DEGREE_TO_RADIANS),Math.sin(60*DEGREE_TO_RADIANS),
Math.sin(61*DEGREE_TO_RADIANS),Math.sin(62*DEGREE_TO_RADIANS),Math.sin(63*DEGREE_TO_RADIANS),Math.sin(64*DEGREE_TO_RADIANS),Math.sin(65*DEGREE_TO_RADIANS),Math.sin(66*DEGREE_TO_RADIANS),
Math.sin(67*DEGREE_TO_RADIANS),Math.sin(68*DEGREE_TO_RADIANS),Math.sin(69*DEGREE_TO_RADIANS),Math.sin(70*DEGREE_TO_RADIANS),Math.sin(71*DEGREE_TO_RADIANS),Math.sin(72*DEGREE_TO_RADIANS),
Math.sin(73*DEGREE_TO_RADIANS),Math.sin(74*DEGREE_TO_RADIANS),Math.sin(75*DEGREE_TO_RADIANS),Math.sin(76*DEGREE_TO_RADIANS),Math.sin(77*DEGREE_TO_RADIANS),Math.sin(78*DEGREE_TO_RADIANS),
Math.sin(79*DEGREE_TO_RADIANS),Math.sin(80*DEGREE_TO_RADIANS),Math.sin(81*DEGREE_TO_RADIANS),Math.sin(82*DEGREE_TO_RADIANS),Math.sin(83*DEGREE_TO_RADIANS),Math.sin(84*DEGREE_TO_RADIANS),
Math.sin(85*DEGREE_TO_RADIANS),Math.sin(86*DEGREE_TO_RADIANS),Math.sin(87*DEGREE_TO_RADIANS),Math.sin(88*DEGREE_TO_RADIANS),Math.sin(89*DEGREE_TO_RADIANS),Math.sin(90*DEGREE_TO_RADIANS),
Math.sin(91*DEGREE_TO_RADIANS),Math.sin(92*DEGREE_TO_RADIANS),Math.sin(93*DEGREE_TO_RADIANS),Math.sin(94*DEGREE_TO_RADIANS),Math.sin(95*DEGREE_TO_RADIANS),Math.sin(96*DEGREE_TO_RADIANS),
Math.sin(97*DEGREE_TO_RADIANS),Math.sin(98*DEGREE_TO_RADIANS),Math.sin(99*DEGREE_TO_RADIANS),Math.sin(100*DEGREE_TO_RADIANS),Math.sin(101*DEGREE_TO_RADIANS),Math.sin(102*DEGREE_TO_RADIANS),
Math.sin(103*DEGREE_TO_RADIANS),Math.sin(104*DEGREE_TO_RADIANS),Math.sin(105*DEGREE_TO_RADIANS),Math.sin(106*DEGREE_TO_RADIANS),Math.sin(107*DEGREE_TO_RADIANS),Math.sin(108*DEGREE_TO_RADIANS),
Math.sin(109*DEGREE_TO_RADIANS),Math.sin(110*DEGREE_TO_RADIANS),Math.sin(111*DEGREE_TO_RADIANS),Math.sin(112*DEGREE_TO_RADIANS),Math.sin(113*DEGREE_TO_RADIANS),Math.sin(114*DEGREE_TO_RADIANS),
Math.sin(115*DEGREE_TO_RADIANS),Math.sin(116*DEGREE_TO_RADIANS),Math.sin(117*DEGREE_TO_RADIANS),Math.sin(118*DEGREE_TO_RADIANS),Math.sin(119*DEGREE_TO_RADIANS),Math.sin(120*DEGREE_TO_RADIANS),
Math.sin(121*DEGREE_TO_RADIANS),Math.sin(122*DEGREE_TO_RADIANS),Math.sin(123*DEGREE_TO_RADIANS),Math.sin(124*DEGREE_TO_RADIANS),Math.sin(125*DEGREE_TO_RADIANS),Math.sin(126*DEGREE_TO_RADIANS),
Math.sin(127*DEGREE_TO_RADIANS),Math.sin(128*DEGREE_TO_RADIANS),Math.sin(129*DEGREE_TO_RADIANS),Math.sin(130*DEGREE_TO_RADIANS),Math.sin(131*DEGREE_TO_RADIANS),Math.sin(132*DEGREE_TO_RADIANS),
Math.sin(133*DEGREE_TO_RADIANS),Math.sin(134*DEGREE_TO_RADIANS),Math.sin(135*DEGREE_TO_RADIANS),Math.sin(136*DEGREE_TO_RADIANS),Math.sin(137*DEGREE_TO_RADIANS),Math.sin(138*DEGREE_TO_RADIANS),
Math.sin(139*DEGREE_TO_RADIANS),Math.sin(140*DEGREE_TO_RADIANS),Math.sin(141*DEGREE_TO_RADIANS),Math.sin(142*DEGREE_TO_RADIANS),Math.sin(143*DEGREE_TO_RADIANS),Math.sin(144*DEGREE_TO_RADIANS),
Math.sin(145*DEGREE_TO_RADIANS),Math.sin(146*DEGREE_TO_RADIANS),Math.sin(147*DEGREE_TO_RADIANS),Math.sin(148*DEGREE_TO_RADIANS),Math.sin(149*DEGREE_TO_RADIANS),Math.sin(150*DEGREE_TO_RADIANS),
Math.sin(151*DEGREE_TO_RADIANS),Math.sin(152*DEGREE_TO_RADIANS),Math.sin(153*DEGREE_TO_RADIANS),Math.sin(154*DEGREE_TO_RADIANS),Math.sin(155*DEGREE_TO_RADIANS),Math.sin(156*DEGREE_TO_RADIANS),
Math.sin(157*DEGREE_TO_RADIANS),Math.sin(158*DEGREE_TO_RADIANS),Math.sin(159*DEGREE_TO_RADIANS),Math.sin(160*DEGREE_TO_RADIANS),Math.sin(161*DEGREE_TO_RADIANS),Math.sin(162*DEGREE_TO_RADIANS),
Math.sin(163*DEGREE_TO_RADIANS),Math.sin(164*DEGREE_TO_RADIANS),Math.sin(165*DEGREE_TO_RADIANS),Math.sin(166*DEGREE_TO_RADIANS),Math.sin(167*DEGREE_TO_RADIANS),Math.sin(168*DEGREE_TO_RADIANS),
Math.sin(169*DEGREE_TO_RADIANS),Math.sin(170*DEGREE_TO_RADIANS),Math.sin(171*DEGREE_TO_RADIANS),Math.sin(172*DEGREE_TO_RADIANS),Math.sin(173*DEGREE_TO_RADIANS),Math.sin(174*DEGREE_TO_RADIANS),
Math.sin(175*DEGREE_TO_RADIANS),Math.sin(176*DEGREE_TO_RADIANS),Math.sin(177*DEGREE_TO_RADIANS),Math.sin(178*DEGREE_TO_RADIANS),Math.sin(179*DEGREE_TO_RADIANS),Math.sin(180*DEGREE_TO_RADIANS)];//-180-->180度
		/**
		 *角度的cos值，从（-180度~~180度） 
		 */									
		public static var COS: Array = [Math.cos(-180*DEGREE_TO_RADIANS),
Math.cos(-179*DEGREE_TO_RADIANS),Math.cos(-178*DEGREE_TO_RADIANS),Math.cos(-177*DEGREE_TO_RADIANS),Math.cos(-176*DEGREE_TO_RADIANS),Math.cos(-175*DEGREE_TO_RADIANS),Math.cos(-174*DEGREE_TO_RADIANS),
Math.cos(-173*DEGREE_TO_RADIANS),Math.cos(-172*DEGREE_TO_RADIANS),Math.cos(-171*DEGREE_TO_RADIANS),Math.cos(-170*DEGREE_TO_RADIANS),Math.cos(-169*DEGREE_TO_RADIANS),Math.cos(-168*DEGREE_TO_RADIANS),
Math.cos(-167*DEGREE_TO_RADIANS),Math.cos(-166*DEGREE_TO_RADIANS),Math.cos(-165*DEGREE_TO_RADIANS),Math.cos(-164*DEGREE_TO_RADIANS),Math.cos(-163*DEGREE_TO_RADIANS),Math.cos(-162*DEGREE_TO_RADIANS),
Math.cos(-161*DEGREE_TO_RADIANS),Math.cos(-160*DEGREE_TO_RADIANS),Math.cos(-159*DEGREE_TO_RADIANS),Math.cos(-158*DEGREE_TO_RADIANS),Math.cos(-157*DEGREE_TO_RADIANS),Math.cos(-156*DEGREE_TO_RADIANS),
Math.cos(-155*DEGREE_TO_RADIANS),Math.cos(-154*DEGREE_TO_RADIANS),Math.cos(-153*DEGREE_TO_RADIANS),Math.cos(-152*DEGREE_TO_RADIANS),Math.cos(-151*DEGREE_TO_RADIANS),Math.cos(-150*DEGREE_TO_RADIANS),
Math.cos(-149*DEGREE_TO_RADIANS),Math.cos(-148*DEGREE_TO_RADIANS),Math.cos(-147*DEGREE_TO_RADIANS),Math.cos(-146*DEGREE_TO_RADIANS),Math.cos(-145*DEGREE_TO_RADIANS),Math.cos(-144*DEGREE_TO_RADIANS),
Math.cos(-143*DEGREE_TO_RADIANS),Math.cos(-142*DEGREE_TO_RADIANS),Math.cos(-141*DEGREE_TO_RADIANS),Math.cos(-140*DEGREE_TO_RADIANS),Math.cos(-139*DEGREE_TO_RADIANS),Math.cos(-138*DEGREE_TO_RADIANS),
Math.cos(-137*DEGREE_TO_RADIANS),Math.cos(-136*DEGREE_TO_RADIANS),Math.cos(-135*DEGREE_TO_RADIANS),Math.cos(-134*DEGREE_TO_RADIANS),Math.cos(-133*DEGREE_TO_RADIANS),Math.cos(-132*DEGREE_TO_RADIANS),
Math.cos(-131*DEGREE_TO_RADIANS),Math.cos(-130*DEGREE_TO_RADIANS),Math.cos(-129*DEGREE_TO_RADIANS),Math.cos(-128*DEGREE_TO_RADIANS),Math.cos(-127*DEGREE_TO_RADIANS),Math.cos(-126*DEGREE_TO_RADIANS),
Math.cos(-125*DEGREE_TO_RADIANS),Math.cos(-124*DEGREE_TO_RADIANS),Math.cos(-123*DEGREE_TO_RADIANS),Math.cos(-122*DEGREE_TO_RADIANS),Math.cos(-121*DEGREE_TO_RADIANS),Math.cos(-120*DEGREE_TO_RADIANS),
Math.cos(-119*DEGREE_TO_RADIANS),Math.cos(-118*DEGREE_TO_RADIANS),Math.cos(-117*DEGREE_TO_RADIANS),Math.cos(-116*DEGREE_TO_RADIANS),Math.cos(-115*DEGREE_TO_RADIANS),Math.cos(-114*DEGREE_TO_RADIANS),
Math.cos(-113*DEGREE_TO_RADIANS),Math.cos(-112*DEGREE_TO_RADIANS),Math.cos(-111*DEGREE_TO_RADIANS),Math.cos(-110*DEGREE_TO_RADIANS),Math.cos(-109*DEGREE_TO_RADIANS),Math.cos(-108*DEGREE_TO_RADIANS),
Math.cos(-107*DEGREE_TO_RADIANS),Math.cos(-106*DEGREE_TO_RADIANS),Math.cos(-105*DEGREE_TO_RADIANS),Math.cos(-104*DEGREE_TO_RADIANS),Math.cos(-103*DEGREE_TO_RADIANS),Math.cos(-102*DEGREE_TO_RADIANS),
Math.cos(-101*DEGREE_TO_RADIANS),Math.cos(-100*DEGREE_TO_RADIANS),Math.cos(-99*DEGREE_TO_RADIANS),Math.cos(-98*DEGREE_TO_RADIANS),Math.cos(-97*DEGREE_TO_RADIANS),Math.cos(-96*DEGREE_TO_RADIANS),
Math.cos(-95*DEGREE_TO_RADIANS),Math.cos(-94*DEGREE_TO_RADIANS),Math.cos(-93*DEGREE_TO_RADIANS),Math.cos(-92*DEGREE_TO_RADIANS),Math.cos(-91*DEGREE_TO_RADIANS),Math.cos(-90*DEGREE_TO_RADIANS),
Math.cos(-89*DEGREE_TO_RADIANS),Math.cos(-88*DEGREE_TO_RADIANS),Math.cos(-87*DEGREE_TO_RADIANS),Math.cos(-86*DEGREE_TO_RADIANS),Math.cos(-85*DEGREE_TO_RADIANS),Math.cos(-84*DEGREE_TO_RADIANS),
Math.cos(-83*DEGREE_TO_RADIANS),Math.cos(-82*DEGREE_TO_RADIANS),Math.cos(-81*DEGREE_TO_RADIANS),Math.cos(-80*DEGREE_TO_RADIANS),Math.cos(-79*DEGREE_TO_RADIANS),Math.cos(-78*DEGREE_TO_RADIANS),
Math.cos(-77*DEGREE_TO_RADIANS),Math.cos(-76*DEGREE_TO_RADIANS),Math.cos(-75*DEGREE_TO_RADIANS),Math.cos(-74*DEGREE_TO_RADIANS),Math.cos(-73*DEGREE_TO_RADIANS),Math.cos(-72*DEGREE_TO_RADIANS),
Math.cos(-71*DEGREE_TO_RADIANS),Math.cos(-70*DEGREE_TO_RADIANS),Math.cos(-69*DEGREE_TO_RADIANS),Math.cos(-68*DEGREE_TO_RADIANS),Math.cos(-67*DEGREE_TO_RADIANS),Math.cos(-66*DEGREE_TO_RADIANS),
Math.cos(-65*DEGREE_TO_RADIANS),Math.cos(-64*DEGREE_TO_RADIANS),Math.cos(-63*DEGREE_TO_RADIANS),Math.cos(-62*DEGREE_TO_RADIANS),Math.cos(-61*DEGREE_TO_RADIANS),Math.cos(-60*DEGREE_TO_RADIANS),
Math.cos(-59*DEGREE_TO_RADIANS),Math.cos(-58*DEGREE_TO_RADIANS),Math.cos(-57*DEGREE_TO_RADIANS),Math.cos(-56*DEGREE_TO_RADIANS),Math.cos(-55*DEGREE_TO_RADIANS),Math.cos(-54*DEGREE_TO_RADIANS),
Math.cos(-53*DEGREE_TO_RADIANS),Math.cos(-52*DEGREE_TO_RADIANS),Math.cos(-51*DEGREE_TO_RADIANS),Math.cos(-50*DEGREE_TO_RADIANS),Math.cos(-49*DEGREE_TO_RADIANS),Math.cos(-48*DEGREE_TO_RADIANS),
Math.cos(-47*DEGREE_TO_RADIANS),Math.cos(-46*DEGREE_TO_RADIANS),Math.cos(-45*DEGREE_TO_RADIANS),Math.cos(-44*DEGREE_TO_RADIANS),Math.cos(-43*DEGREE_TO_RADIANS),Math.cos(-42*DEGREE_TO_RADIANS),
Math.cos(-41*DEGREE_TO_RADIANS),Math.cos(-40*DEGREE_TO_RADIANS),Math.cos(-39*DEGREE_TO_RADIANS),Math.cos(-38*DEGREE_TO_RADIANS),Math.cos(-37*DEGREE_TO_RADIANS),Math.cos(-36*DEGREE_TO_RADIANS),
Math.cos(-35*DEGREE_TO_RADIANS),Math.cos(-34*DEGREE_TO_RADIANS),Math.cos(-33*DEGREE_TO_RADIANS),Math.cos(-32*DEGREE_TO_RADIANS),Math.cos(-31*DEGREE_TO_RADIANS),Math.cos(-30*DEGREE_TO_RADIANS),
Math.cos(-29*DEGREE_TO_RADIANS),Math.cos(-28*DEGREE_TO_RADIANS),Math.cos(-27*DEGREE_TO_RADIANS),Math.cos(-26*DEGREE_TO_RADIANS),Math.cos(-25*DEGREE_TO_RADIANS),Math.cos(-24*DEGREE_TO_RADIANS),
Math.cos(-23*DEGREE_TO_RADIANS),Math.cos(-22*DEGREE_TO_RADIANS),Math.cos(-21*DEGREE_TO_RADIANS),Math.cos(-20*DEGREE_TO_RADIANS),Math.cos(-19*DEGREE_TO_RADIANS),Math.cos(-18*DEGREE_TO_RADIANS),
Math.cos(-17*DEGREE_TO_RADIANS),Math.cos(-16*DEGREE_TO_RADIANS),Math.cos(-15*DEGREE_TO_RADIANS),Math.cos(-14*DEGREE_TO_RADIANS),Math.cos(-13*DEGREE_TO_RADIANS),Math.cos(-12*DEGREE_TO_RADIANS),
Math.cos(-11*DEGREE_TO_RADIANS),Math.cos(-10*DEGREE_TO_RADIANS),Math.cos(-9*DEGREE_TO_RADIANS),Math.cos(-8*DEGREE_TO_RADIANS),Math.cos(-7*DEGREE_TO_RADIANS),Math.cos(-6*DEGREE_TO_RADIANS),
Math.cos(-5*DEGREE_TO_RADIANS),Math.cos(-4*DEGREE_TO_RADIANS),Math.cos(-3*DEGREE_TO_RADIANS),Math.cos(-2*DEGREE_TO_RADIANS),Math.cos(-1*DEGREE_TO_RADIANS),Math.cos(0*DEGREE_TO_RADIANS),
Math.cos(1*DEGREE_TO_RADIANS),Math.cos(2*DEGREE_TO_RADIANS),Math.cos(3*DEGREE_TO_RADIANS),Math.cos(4*DEGREE_TO_RADIANS),Math.cos(5*DEGREE_TO_RADIANS),Math.cos(6*DEGREE_TO_RADIANS),
Math.cos(7*DEGREE_TO_RADIANS),Math.cos(8*DEGREE_TO_RADIANS),Math.cos(9*DEGREE_TO_RADIANS),Math.cos(10*DEGREE_TO_RADIANS),Math.cos(11*DEGREE_TO_RADIANS),Math.cos(12*DEGREE_TO_RADIANS),
Math.cos(13*DEGREE_TO_RADIANS),Math.cos(14*DEGREE_TO_RADIANS),Math.cos(15*DEGREE_TO_RADIANS),Math.cos(16*DEGREE_TO_RADIANS),Math.cos(17*DEGREE_TO_RADIANS),Math.cos(18*DEGREE_TO_RADIANS),
Math.cos(19*DEGREE_TO_RADIANS),Math.cos(20*DEGREE_TO_RADIANS),Math.cos(21*DEGREE_TO_RADIANS),Math.cos(22*DEGREE_TO_RADIANS),Math.cos(23*DEGREE_TO_RADIANS),Math.cos(24*DEGREE_TO_RADIANS),
Math.cos(25*DEGREE_TO_RADIANS),Math.cos(26*DEGREE_TO_RADIANS),Math.cos(27*DEGREE_TO_RADIANS),Math.cos(28*DEGREE_TO_RADIANS),Math.cos(29*DEGREE_TO_RADIANS),Math.cos(30*DEGREE_TO_RADIANS),
Math.cos(31*DEGREE_TO_RADIANS),Math.cos(32*DEGREE_TO_RADIANS),Math.cos(33*DEGREE_TO_RADIANS),Math.cos(34*DEGREE_TO_RADIANS),Math.cos(35*DEGREE_TO_RADIANS),Math.cos(36*DEGREE_TO_RADIANS),
Math.cos(37*DEGREE_TO_RADIANS),Math.cos(38*DEGREE_TO_RADIANS),Math.cos(39*DEGREE_TO_RADIANS),Math.cos(40*DEGREE_TO_RADIANS),Math.cos(41*DEGREE_TO_RADIANS),Math.cos(42*DEGREE_TO_RADIANS),
Math.cos(43*DEGREE_TO_RADIANS),Math.cos(44*DEGREE_TO_RADIANS),Math.cos(45*DEGREE_TO_RADIANS),Math.cos(46*DEGREE_TO_RADIANS),Math.cos(47*DEGREE_TO_RADIANS),Math.cos(48*DEGREE_TO_RADIANS),
Math.cos(49*DEGREE_TO_RADIANS),Math.cos(50*DEGREE_TO_RADIANS),Math.cos(51*DEGREE_TO_RADIANS),Math.cos(52*DEGREE_TO_RADIANS),Math.cos(53*DEGREE_TO_RADIANS),Math.cos(54*DEGREE_TO_RADIANS),
Math.cos(55*DEGREE_TO_RADIANS),Math.cos(56*DEGREE_TO_RADIANS),Math.cos(57*DEGREE_TO_RADIANS),Math.cos(58*DEGREE_TO_RADIANS),Math.cos(59*DEGREE_TO_RADIANS),Math.cos(60*DEGREE_TO_RADIANS),
Math.cos(61*DEGREE_TO_RADIANS),Math.cos(62*DEGREE_TO_RADIANS),Math.cos(63*DEGREE_TO_RADIANS),Math.cos(64*DEGREE_TO_RADIANS),Math.cos(65*DEGREE_TO_RADIANS),Math.cos(66*DEGREE_TO_RADIANS),
Math.cos(67*DEGREE_TO_RADIANS),Math.cos(68*DEGREE_TO_RADIANS),Math.cos(69*DEGREE_TO_RADIANS),Math.cos(70*DEGREE_TO_RADIANS),Math.cos(71*DEGREE_TO_RADIANS),Math.cos(72*DEGREE_TO_RADIANS),
Math.cos(73*DEGREE_TO_RADIANS),Math.cos(74*DEGREE_TO_RADIANS),Math.cos(75*DEGREE_TO_RADIANS),Math.cos(76*DEGREE_TO_RADIANS),Math.cos(77*DEGREE_TO_RADIANS),Math.cos(78*DEGREE_TO_RADIANS),
Math.cos(79*DEGREE_TO_RADIANS),Math.cos(80*DEGREE_TO_RADIANS),Math.cos(81*DEGREE_TO_RADIANS),Math.cos(82*DEGREE_TO_RADIANS),Math.cos(83*DEGREE_TO_RADIANS),Math.cos(84*DEGREE_TO_RADIANS),
Math.cos(85*DEGREE_TO_RADIANS),Math.cos(86*DEGREE_TO_RADIANS),Math.cos(87*DEGREE_TO_RADIANS),Math.cos(88*DEGREE_TO_RADIANS),Math.cos(89*DEGREE_TO_RADIANS),Math.cos(90*DEGREE_TO_RADIANS),
Math.cos(91*DEGREE_TO_RADIANS),Math.cos(92*DEGREE_TO_RADIANS),Math.cos(93*DEGREE_TO_RADIANS),Math.cos(94*DEGREE_TO_RADIANS),Math.cos(95*DEGREE_TO_RADIANS),Math.cos(96*DEGREE_TO_RADIANS),
Math.cos(97*DEGREE_TO_RADIANS),Math.cos(98*DEGREE_TO_RADIANS),Math.cos(99*DEGREE_TO_RADIANS),Math.cos(100*DEGREE_TO_RADIANS),Math.cos(101*DEGREE_TO_RADIANS),Math.cos(102*DEGREE_TO_RADIANS),
Math.cos(103*DEGREE_TO_RADIANS),Math.cos(104*DEGREE_TO_RADIANS),Math.cos(105*DEGREE_TO_RADIANS),Math.cos(106*DEGREE_TO_RADIANS),Math.cos(107*DEGREE_TO_RADIANS),Math.cos(108*DEGREE_TO_RADIANS),
Math.cos(109*DEGREE_TO_RADIANS),Math.cos(110*DEGREE_TO_RADIANS),Math.cos(111*DEGREE_TO_RADIANS),Math.cos(112*DEGREE_TO_RADIANS),Math.cos(113*DEGREE_TO_RADIANS),Math.cos(114*DEGREE_TO_RADIANS),
Math.cos(115*DEGREE_TO_RADIANS),Math.cos(116*DEGREE_TO_RADIANS),Math.cos(117*DEGREE_TO_RADIANS),Math.cos(118*DEGREE_TO_RADIANS),Math.cos(119*DEGREE_TO_RADIANS),Math.cos(120*DEGREE_TO_RADIANS),
Math.cos(121*DEGREE_TO_RADIANS),Math.cos(122*DEGREE_TO_RADIANS),Math.cos(123*DEGREE_TO_RADIANS),Math.cos(124*DEGREE_TO_RADIANS),Math.cos(125*DEGREE_TO_RADIANS),Math.cos(126*DEGREE_TO_RADIANS),
Math.cos(127*DEGREE_TO_RADIANS),Math.cos(128*DEGREE_TO_RADIANS),Math.cos(129*DEGREE_TO_RADIANS),Math.cos(130*DEGREE_TO_RADIANS),Math.cos(131*DEGREE_TO_RADIANS),Math.cos(132*DEGREE_TO_RADIANS),
Math.cos(133*DEGREE_TO_RADIANS),Math.cos(134*DEGREE_TO_RADIANS),Math.cos(135*DEGREE_TO_RADIANS),Math.cos(136*DEGREE_TO_RADIANS),Math.cos(137*DEGREE_TO_RADIANS),Math.cos(138*DEGREE_TO_RADIANS),
Math.cos(139*DEGREE_TO_RADIANS),Math.cos(140*DEGREE_TO_RADIANS),Math.cos(141*DEGREE_TO_RADIANS),Math.cos(142*DEGREE_TO_RADIANS),Math.cos(143*DEGREE_TO_RADIANS),Math.cos(144*DEGREE_TO_RADIANS),
Math.cos(145*DEGREE_TO_RADIANS),Math.cos(146*DEGREE_TO_RADIANS),Math.cos(147*DEGREE_TO_RADIANS),Math.cos(148*DEGREE_TO_RADIANS),Math.cos(149*DEGREE_TO_RADIANS),Math.cos(150*DEGREE_TO_RADIANS),
Math.cos(151*DEGREE_TO_RADIANS),Math.cos(152*DEGREE_TO_RADIANS),Math.cos(153*DEGREE_TO_RADIANS),Math.cos(154*DEGREE_TO_RADIANS),Math.cos(155*DEGREE_TO_RADIANS),Math.cos(156*DEGREE_TO_RADIANS),
Math.cos(157*DEGREE_TO_RADIANS),Math.cos(158*DEGREE_TO_RADIANS),Math.cos(159*DEGREE_TO_RADIANS),Math.cos(160*DEGREE_TO_RADIANS),Math.cos(161*DEGREE_TO_RADIANS),Math.cos(162*DEGREE_TO_RADIANS),
Math.cos(163*DEGREE_TO_RADIANS),Math.cos(164*DEGREE_TO_RADIANS),Math.cos(165*DEGREE_TO_RADIANS),Math.cos(166*DEGREE_TO_RADIANS),Math.cos(167*DEGREE_TO_RADIANS),Math.cos(168*DEGREE_TO_RADIANS),
Math.cos(169*DEGREE_TO_RADIANS),Math.cos(170*DEGREE_TO_RADIANS),Math.cos(171*DEGREE_TO_RADIANS),Math.cos(172*DEGREE_TO_RADIANS),Math.cos(173*DEGREE_TO_RADIANS),Math.cos(174*DEGREE_TO_RADIANS),
Math.cos(175*DEGREE_TO_RADIANS),Math.cos(176*DEGREE_TO_RADIANS),Math.cos(177*DEGREE_TO_RADIANS),Math.cos(178*DEGREE_TO_RADIANS),Math.cos(179*DEGREE_TO_RADIANS),Math.cos(180*DEGREE_TO_RADIANS)];//-180-->180度
		
		/**
		 * 取得两点的角度 
		 * @param start_x		起始点
		 * @param start_y
		 * @param end_x			终点
		 * @param end_y
		 * @return 
		 * 
		 */		
		public static function getAngle(start_x: Number, start_y: Number, end_x: Number, end_y: Number): int {
			var _dx: Number = end_x - start_x;
			var _dy: Number = end_y - start_y;
			
			return Math.atan2(_dy,_dx) * RADIANS_TO_DEGREE;
		}
	}
	
}