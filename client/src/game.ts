import { Application, Assets, Sprite } from "pixi.js";
import andreURI from "../assets/characters/andre.png";

export class Game {
    app = new Application();
    sprites = new Map<string, Sprite>();
    pressedKeys = new Set<string>();

    constructor() {}

    async init() {
        await this.app.init({
            width: 1920,
            height: 1080,
            eventFeatures: {
                move: true,
            },
        });
        this.app.canvas.style.imageRendering = "pixelated";
        document.body.appendChild(this.app.canvas);

        this.sprites.set("andre", new Sprite(await Assets.load(andreURI)));
        const andre = this.sprites.get("andre")!;
        andre.texture.source.scaleMode = "nearest";
        andre.anchor.set(0.5, 0.5);
        andre.setSize(128);
        andre.x = this.app.renderer.width / 2;
        andre.y = this.app.renderer.height / 2;

        this.app.stage.addChild(andre!);

        this.app.ticker.add(() => this.update(this));
        this.app.stage.on("mousemove", (event) => {
            console.log(event.x, event.y);
        });

        document.addEventListener("keydown", (event) => {
            this.pressedKeys.add(event.key.toLowerCase());
        });

        document.addEventListener("keyup", (event) => {
            this.pressedKeys.delete(event.key.toLowerCase());
        });
    }

    update(self: Game) {
        const deltaTime = self.app.ticker.deltaMS / 1000;
        const andre = self.sprites.get("andre")!;
        if (self.pressedKeys.has("a")) {
            andre.x -= 200 * deltaTime;
        }
        if (self.pressedKeys.has("d")) {
            andre.x += 200 * deltaTime;
        }
    }
}
