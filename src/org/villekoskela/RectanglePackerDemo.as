/**
 * Rectangle Packer demo
 *
 * Copyright 2012 Ville Koskela. All rights reserved.
 *
 * Email: ville@villekoskela.org
 * Blog: http://villekoskela.org
 * Twitter: @villekoskelaorg
 *
 * You may redistribute, use and/or modify this source code freely
 * but this copyright statement must not be removed from the source files.
 *
 * The package structure of the source code must remain unchanged.
 * Mentioning the author in the binary distributions is highly appreciated.
 *
 * If you use this utility it would be nice to hear about it so feel free to drop
 * an email.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. *
 *
 */
package org.villekoskela
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.geom.Rectangle;
    import flash.text.TextField;
    import flash.utils.getTimer;

    import org.villekoskela.tools.ScalingBox;
    import org.villekoskela.utils.RectanglePacker;

    /**
     * Simple demo application for the RectanglePacker class.
     * Should not be used as a reference for anything :)
     */
    [SWF(width="480", height="480", frameRate="60", backgroundColor="#FFFFFF")]
    public class RectanglePackerDemo extends Sprite
    {
        private static const WIDTH:int = 480;
        private static const HEIGHT:int = 480;
        private static const Y_MARGIN:int = 40;
        private static const BOX_MARGIN:int = 15;

        private static const RECTANGLE_COUNT:int = 500;
        private static const SIZE_MULTIPLIER:Number = 2;

        private var mBitmapData:BitmapData = new BitmapData(WIDTH, HEIGHT, true, 0xFFFFFFFF);
        private var mCopyRight:TextField = new TextField();
        private var mText:TextField = new TextField();

        private var mPacker:RectanglePacker;
        private var mScalingBox:ScalingBox;

        private var mRectangles:Vector.<Rectangle> = new Vector.<Rectangle>();

        public function RectanglePackerDemo()
        {
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            addEventListener(Event.ENTER_FRAME, onEnterFrame);

            var bitmap:Bitmap = new Bitmap(mBitmapData);
            addChild(bitmap);
            bitmap.x = BOX_MARGIN;
            bitmap.y = Y_MARGIN;

            mCopyRight.x = BOX_MARGIN;
            mCopyRight.y = BOX_MARGIN / 3;
            mCopyRight.width = 300;
            mCopyRight.text = "Rectangle Packer (c) villekoskela.org";
            addChild(mCopyRight);

            mText.x = WIDTH - 200;
            mText.y = BOX_MARGIN / 3;
            mText.width = 200;
            addChild(mText);

            mScalingBox = new ScalingBox(BOX_MARGIN, Y_MARGIN, WIDTH - (BOX_MARGIN*2), HEIGHT - (Y_MARGIN + (BOX_MARGIN*2)));
            addChild(mScalingBox);

            createRectangles();
        }

        /**
         * Create some random size rectangles to play with
         */
        private function createRectangles():void
        {
            var width:int;
            var height:int;
            for (var i:int = 0; i < 10; i++)
            {
                width = 20 * SIZE_MULTIPLIER + Math.floor(Math.random() * 8) * SIZE_MULTIPLIER * SIZE_MULTIPLIER;
                height = 20 * SIZE_MULTIPLIER + Math.floor(Math.random() * 8) * SIZE_MULTIPLIER * SIZE_MULTIPLIER;
                mRectangles.push(new Rectangle(0, 0, width, height));
            }

            for (var j:int = 10; j < RECTANGLE_COUNT; j++)
            {
                width = 3 * SIZE_MULTIPLIER + Math.floor(Math.random() * 8) * SIZE_MULTIPLIER;
                height = 3 * SIZE_MULTIPLIER + Math.floor(Math.random() * 8) * SIZE_MULTIPLIER;
                mRectangles.push(new Rectangle(0, 0, width, height));
            }
        }

        private function onAddedToStage(event:Event):void
        {
            updateRectangles();
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP;
        }

        private function onEnterFrame(event:Event):void
        {
            if (mScalingBox.boxWidth != mScalingBox.newBoxWidth || mScalingBox.boxHeight != mScalingBox.newBoxHeight)
            {
                updateRectangles();
            }
        }

        private function updateRectangles():void
        {
            var start:int = getTimer();
			const padding:int = 1;

            if (mPacker == null)
            {
                mPacker = new RectanglePacker(mScalingBox.newBoxWidth, mScalingBox.newBoxHeight, padding);
            }
            else
            {
                mPacker.reset(mScalingBox.newBoxWidth, mScalingBox.newBoxHeight, padding);
            }

            for (var i:int = 0; i < RECTANGLE_COUNT; i++)
            {
                mPacker.insertRectangle(mRectangles[i].width, mRectangles[i].height, i);
            }

            mPacker.packRectangles();

            var end:int = getTimer();

            if (mPacker.rectangleCount > 0)
            {
                mText.text = mPacker.rectangleCount + " rectangles packed in " + (end - start) + "ms";

                mScalingBox.updateBox(mScalingBox.newBoxWidth, mScalingBox.newBoxHeight);
                mBitmapData.fillRect(mBitmapData.rect, 0xFFFFFFFF);
                var rect:Rectangle = new Rectangle();
                for (var j:int = 0; j < mPacker.rectangleCount; j++)
                {
                    rect = mPacker.getRectangle(j, rect);
                    mBitmapData.fillRect(new Rectangle(rect.x, rect.y, rect.width, rect.height), 0xFF000000);
                    var index:int = mPacker.getRectangleId(j);
                    var color:uint = 0xFF171703 + (((18 * ((index + 4) % 13)) << 16) + ((31 * ((index * 3) % 8)) << 8) + 63 * (((index + 1) * 3) % 5));
                    mBitmapData.fillRect(new Rectangle(rect.x + 1, rect.y + 1, rect.width - 2, rect.height - 2), color);
                }
            }
        }
    }
}
