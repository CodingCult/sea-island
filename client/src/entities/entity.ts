import { Sprite } from "pixi.js";

const GRAVITY = -1000;

export default class Entity extends Sprite {
    realPosition = { x: 0, y: 0 };
    velocity = { x: 0, y: 0 };
    acceleration = { x: 0, y: GRAVITY };
    // TODO add animations

    constructor() {
        super();
    }

    update(deltaTime: number) {
        this.velocity.y += this.acceleration.y * deltaTime;
        this.velocity.x += this.acceleration.x * deltaTime;

        this.realPosition.y += this.velocity.y * deltaTime;
        this.realPosition.x += this.velocity.x * deltaTime;

        if (this.realPosition.y < 128 / 2) {
            this.realPosition.y = 128 / 2;
        }

        this.x = Math.round(this.realPosition.x / 8) * 8;
        this.y = 1080 - Math.round(this.realPosition.y / 8) * 8;
    }
}
