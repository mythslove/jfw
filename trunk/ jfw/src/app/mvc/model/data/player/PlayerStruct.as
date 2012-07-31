package app.mvc.model.data.player
{
	import app.mvc.model.data.AbsStruct;
	
	import com.jfw.engine.core.data.BaseStruct;
	
	public class PlayerStruct extends AbsStruct
	{
		/** 称号 */
		public var callName:String = '';
		
		/** 用户性别 0女 1男 */
		public var sex:int;
		
		/** 出生日期 */
		public var date:String;
		
		/** 头像地址 */
		public var thumb:String = '';
		
		/** 是否VIP */
		public var vip:int ;
		
		/** VIP等级 */
		public var viplv:int;
		
		/** 注册日期 */
		public var reg:String;
		
		/** 经验 */
		public var exp:int;
		
		/** 血量 */
		public var hp:int;
		
		/** 妖币 */
		public var yb:int;
		
		/** 金币 */
		public var gb:int;
		
		/** 猴毛（军令）*/
		public var power:int;
		
		/** 攻击 */
		public var att:int;
		
		/** 防御 */
		public var def:int;
		
		/** 速度 */
		public var sp:int;
		
		/** 技能 */
		public var sk:int;
		
		/** 积分 */
		public var jifen:int ;
		
		/** 幸运值 */
		public var lucky:int ;
		
		/** 好友度 */
		public var friendly:int;
		
		/** 当前地图序号 */
		public var clvid:int;
		
		/** 格子数 */
		public var ecell:int;
		
		/** cd时间 */
		public var strcd:int;
		
		public var equip:Array = [];
		
		/** 装备 */
		public var eq1:Object;
		public var eq2:Object;
		public var eq3:Object;
		public var eq4:Object;
		public var eq5:Object;
		
		/** 是否新手引导完成 */
		public var isguide:int;
		
		/** 成人，防沉迷预留 */
		public var isAdult:Boolean = true;
		
		public function PlayerStruct(obj:Object=null)
		{
			super(obj);
		}
		
		override protected function parse( obj:Object ):void
		{
			this.id = obj.id;
			this.srcid = obj.srcid;
			this.name = obj.name ? obj.name : 'Nick Name';
			this.lv = obj.lv;
			this.type = obj.type;
			this.callName = obj.callName;
			this.sex = obj.sex;
			this.date = obj.date;
			this.thumb = obj.thumb ? obj.thumb : 'http://head.xiaonei.com/photos/0/0/men_head.gif';
			this.vip = obj.vip;
			this.viplv = obj.viplv;
			this.reg = obj.reg;
			this.exp = obj.exp;
			this.hp = obj.hp;
			this.power = obj.power;
			this.yb = obj.yb;
			this.gb = obj.gb;
			this.att = obj.att;
			this.def = obj.def;
			this.sp = obj.sp;
			this.sk = obj.sk;
			this.jifen = obj.jifen;
			this.lucky = obj.lucky;
			this.friendly = obj.friendly;
			
			this.equip = obj.equip;
			this.eq1 = ( obj is Array && obj.length == 0 ) ? null: obj.eq1;
			this.eq2 = ( obj is Array && obj.length == 0 ) ? null: obj.eq2;
			this.eq3 = ( obj is Array && obj.length == 0 ) ? null: obj.eq3;
			this.eq4 = ( obj is Array && obj.length == 0 ) ? null: obj.eq4;
			this.eq5 = ( obj is Array && obj.length == 0 ) ? null: obj.eq5;
			this.clvid = obj.clvid;
			this.ecell = obj.ecell;
			this.strcd = obj.strcd;
			this.isguide = obj.isguide; 
			this.isAdult = obj.isAdult;
		}
	}
}