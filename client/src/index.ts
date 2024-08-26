import { Application, Sprite, Assets } from "pixi.js";
import "./styles.css";

const app = new Application();
await app.init({
    width: 1920,
    height: 1080,
});

document.body.appendChild(app.canvas);

const texture = await Assets.load("./assets/bunny.png");
const bunny = new Sprite(texture);

bunny.x = app.renderer.width / 2;
bunny.y = app.renderer.height / 2;

// Rotate around the center
bunny.anchor.x = 0.5;
bunny.anchor.y = 0.5;

// Add the bunny to the scene we are building
app.stage.addChild(bunny);

// Listen for frame updates
app.ticker.add(() => {
    const deltaTime = app.ticker.deltaMS / 1000;
    bunny.rotation += Math.PI * deltaTime;
});

app.stage.on("mousemove", (event) => {
    console.log(event.x, event.y);
});
