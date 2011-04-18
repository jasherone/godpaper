package com.godpaper.as3.business.factory
{
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.IChessFactory;
	import com.godpaper.as3.core.IChessGasket;
	import com.godpaper.as3.core.IChessPiece;
	import com.godpaper.as3.core.IChessVO;
	import com.godpaper.as3.errors.DefaultErrors;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.model.vos.OmenVO;
	import com.godpaper.as3.views.components.ChessGasket;
	import com.godpaper.as3.views.components.ChessPiece;

	import flash.geom.Point;

	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------

	/**
	 * AbstractChessFactory.as class.Simply factory produce ChessPiece/ChessGasket/ChessVO/OmenVO.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jan 27, 2011 3:52:34 PM
	 */
	public class ChessFactoryBase implements IChessFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		protected var chessPieceLabel:String="";
		protected var chessPieceValue:int=0;
		protected var chessPieceType:String="";
		protected var chessPieceSource:Object;
		protected var chessPieceScale:Number=1;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:Logger=LogContext.getLogger(ChessFactoryBase);
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 

		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//-------------------------------------------------------------------------- 

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function ChessFactoryBase()
		{
			//
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		/**
		 * Chess piece manipulate.
		 * @param position chessPiece's position type is Point(x, y).
		 * @param flag chessPices's side flag.(red/blue).
		 * @return ChessPiece component with implement IChessPiece
		 *
		 */
		public function createChessPiece(position:Point, flag:int=0):IChessPiece
		{
			//view
			var simpleChessPiece:ChessPiece = new ChessPiece();
			simpleChessPiece.label=this.chessPieceLabel;
			simpleChessPiece.name=this.chessPieceLabel;
			simpleChessPiece.type=chessPieceType;
			//			simpleChessPiece.swfLoader.source = String("./assets/").concat(chessPieceType,".swf");
			simpleChessPiece.swfLoader.source=this.chessPieceSource;
			simpleChessPiece.swfLoader.scaleX=this.chessPieceScale;
			simpleChessPiece.swfLoader.scaleY=this.chessPieceScale;
			//set flag to identify.
			simpleChessPiece.flag=DefaultConstants.FLAG_BLUE;
			//
			if (this.chessPieceLabel!="")
			{
				if (this.chessPieceType.indexOf(DefaultConstants.RED)!=-1)//red
				{
					simpleChessPiece.flag=DefaultConstants.FLAG_RED; 
					//					ChessPiecesModel.getInstance().redPieces.setBitt(position.y,position.x,true);
					ChessPiecesModel.getInstance()[simpleChessPiece.type].setBitt(position.y, position.x, true);
					//push to reds collection.
					ChessPiecesModel.getInstance().reds.push(simpleChessPiece);
				}
				else //blue
				{
					//simpleChessPiece.enabled = false;
					//					ChessPiecesModel.getInstance().bluePieces.setBitt(position.y,position.x,true);
					ChessPiecesModel.getInstance()[simpleChessPiece.type].setBitt(position.y, position.x, true);
					//push to blues collection.
					ChessPiecesModel.getInstance().blues.push(simpleChessPiece);
				}
			}
			//avoid duplicate usless components.
			if (this.chessPieceLabel!="")
			{
				//data
				simpleChessPiece.position=position;
				LOG.debug("Anew chess piece created!");
				return simpleChessPiece as IChessPiece;
			}
			return null;
		}

		/**
		 * Chess gasket manipulate.
		 * @param position
		 * @return ChessGasket component which implement IChessGasket
		 *
		 */
		public function createChessGasket(position:Point):IChessGasket
		{
			var myChessGasket:ChessGasket=new ChessGasket();
			myChessGasket.position=position;
			myChessGasket.x=position.x * BoardConfig.xOffset - myChessGasket.width / 2 + BoardConfig.xAdjust;
			myChessGasket.y=position.y * BoardConfig.yOffset + BoardConfig.yAdjust;
			myChessGasket.toolTip=position.toString();
			return myChessGasket;
		}

		/**
		 * ChessVO manipulate.
		 * @param conductVO has property target(type is chessPiece) and newPosition([0,1]).
		 * @return precise chess value object(prototype is chessVOBase).
		 *
		 */
		public function generateChessVO(conductVO:ConductVO):IChessVO
		{
			throw new Error(DefaultErrors.INITIALIZE_VIRTUAL_FUNCTION);
			return null;
		}

		/**
		 * OmenVO manipulate.
		 * @param conductVO has property target(type is chessPiece) and newPosition([0,1]).
		 * @return precise chess value object(prototype is OmenVO).
		 *
		 */
		public function generateOmenVO(conductVO:ConductVO):OmenVO
		{
			throw new Error(DefaultErrors.INITIALIZE_VIRTUAL_FUNCTION);
			return null;
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}

}
