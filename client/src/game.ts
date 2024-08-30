import { Application, Assets, Sprite, Text } from "pixi.js";
import andreURI from "../assets/characters/andre.png";
import backgroundURI from "../assets/background.png";

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
                click: true,
            },
            eventMode: "static",
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

        andre.on("click", (_event) => {
            alert("hehhe");
        });

        const text = new Text({
            text: "0 fps",
            style: {
                fontFamily: "Arial",
                fontSize: 48,
                fill: 0xffffff,
                align: "center",
            },
        });
        text.label = "fpsText";

        this.app.stage.addChild(
            new Sprite(await Assets.load(backgroundURI)),
            andre,
            text,
        );

        this.app.ticker.add(() => this.update());

        document.addEventListener("keydown", (event) => {
            this.pressedKeys.add(event.key.toLowerCase());
        });

        document.addEventListener("keyup", (event) => {
            this.pressedKeys.delete(event.key.toLowerCase());
        });

        setInterval(() => {
            (this.app.stage.getChildrenByLabel("fpsText")[0] as Text).text =
                Math.floor(this.app.ticker.FPS) + " fps";
        }, 500);
    }

    update() {
        const deltaTime = this.app.ticker.deltaMS / 1000;
        const andre = this.sprites.get("andre")!;
        if (this.pressedKeys.has("a")) {
            andre.x -= 200 * deltaTime;
        }
        if (this.pressedKeys.has("d")) {
            andre.x += 200 * deltaTime;
        }
    }
}
