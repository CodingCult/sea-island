import Entity from "@/entities/entity";
import andreURI from "@/assets/characters/andre.png";
import { Assets, Texture } from "pixi.js";

export default class Andre extends Entity {
    canJump = false;

    constructor() {
        super();
        (async () => {
            this.texture = new Texture(await Assets.load(andreURI));
            this.texture.source.scaleMode = "nearest";
            this.anchor.set(0.5, 0.5);
            this.setSize(16 * 8);
        })();
    }

    update(deltaTime: number) {
        super.update(deltaTime);
        if (this.realPosition.y <= 128 / 2) {
            this.canJump = true;
        }
    }
}
