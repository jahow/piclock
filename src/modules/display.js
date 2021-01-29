const CELL_SIZE = 10;
const CELL_GUTTER = 2;

const SCREEN_WIDTH = 800;
const SCREEN_HEIGHT = 480;

const colCount = Math.floor(SCREEN_WIDTH / (CELL_SIZE + CELL_GUTTER));
const rowCount = Math.floor(SCREEN_HEIGHT / (CELL_SIZE + CELL_GUTTER));

const canvas = document.createElement('canvas');
canvas.width = colCount * CELL_SIZE + (colCount + 1) * CELL_GUTTER;
canvas.height = rowCount * CELL_SIZE + (rowCount + 1) * CELL_GUTTER;

document.body.appendChild(canvas);

const fps = document.createElement('div');
fps.style.backgroundColor = 'black';
fps.style.color = 'white';
fps.style.fontFamily = 'monospace';

document.body.appendChild(fps);

const colors = ['#33135C', '#FFD300', '#DE38C8', '#652EC7'];

// each cell holds an object containing: current color, target color, transition from back to front (0-1)
const grid = new Array(colCount * rowCount).fill(0).map(() => ({
  frontColor: 0,
  backColor: 0,
  transition: 1,
}));

/** @type {Widget[]} */
const widgets = [];

/**
 * @param {Widget} widget
 */
export function addWidget(widget) {
  widgets.push(widget);
}

let lastTime = Date.now();

const TRANSITION_DURATION = 300;

function render() {
  const now = Date.now();
  const delta = now - lastTime;
  lastTime = now;

  // update widgets each frame
  for (let k = 0; k < widgets.length; k++) {
    widgets[k].update();
  }

  const ctx = /** @type {CanvasRenderingContext2D} */ canvas.getContext('2d');

  // update colors
  for (let i = 0; i < rowCount; i++) {
    for (let j = 0; j < colCount; j++) {
      const gridCell = grid[j + i * colCount];

      // use clear color by default
      let newColor = 0;

      // debug: show borders
      // if (
      //   i === 1 ||
      //   i === 3 ||
      //   i === rowCount - 2 ||
      //   i === rowCount - 4 ||
      //   j === 1 ||
      //   j === 3 ||
      //   j === colCount - 2 ||
      //   j === colCount - 4
      // ) {
      //   newColor = 3;
      // }

      for (let k = 0; k < widgets.length; k++) {
        newColor = widgets[k].render(j, i, newColor);
      }

      if (newColor !== gridCell.frontColor) {
        gridCell.backColor = gridCell.frontColor;
        gridCell.frontColor = newColor;
        gridCell.transition = 0;
      }

      // update transition value
      gridCell.transition = Math.min(
        1,
        gridCell.transition + delta / TRANSITION_DURATION
      );
    }
  }

  // draw striped bg
  ctx.globalAlpha = 0.2;
  ctx.fillStyle = 'black';
  ctx.fillRect(0, 0, canvas.width, canvas.height);
  // for (let i = 0; i <= rowCount; i++) {
  //   ctx.fillStyle = 'black';
  //   ctx.fillRect(
  //     0,
  //     i * (CELL_SIZE + CELL_GUTTER) - CELL_SIZE * 0.25,
  //     canvas.width,
  //     CELL_SIZE * 0.5 + CELL_GUTTER
  //   );
  //   ctx.fillStyle = colors[0];
  //   ctx.fillRect(
  //     0,
  //     i * (CELL_SIZE + CELL_GUTTER) + CELL_GUTTER + CELL_SIZE * 0.25,
  //     canvas.width,
  //     CELL_SIZE * 0.5
  //   );
  // }

  // draw grid
  ctx.lineCap = 'round';
  ctx.globalAlpha = 1;
  ctx.lineWidth = CELL_SIZE;
  for (let i = 0; i < rowCount; i++) {
    for (let j = 0; j < colCount; j++) {
      const gridCell = grid[j + i * colCount];

      if (gridCell.frontColor === 0) continue;

      ctx.strokeStyle = colors[gridCell.frontColor];
      ctx.fillStyle = colors[gridCell.frontColor];

      const x = j * (CELL_SIZE + CELL_GUTTER) + CELL_GUTTER;
      const y = i * (CELL_SIZE + CELL_GUTTER) + CELL_GUTTER + CELL_SIZE / 2;

      // check for similar neighboring cells
      let extraCells = 0;
      // for (let k = j + 1; k < colCount; k++) {
      //   const nextGridCell = grid[k + i * colCount];
      //   if (nextGridCell.frontColor !== gridCell.frontColor) {
      //     break;
      //   }
      //   j++;
      //   extraCells++;
      // }
      const width = CELL_SIZE + extraCells * (CELL_SIZE + CELL_GUTTER);
      const shift = CELL_SIZE * 0.5;

      // ctx.beginPath();
      // ctx.moveTo(x + shift, y);
      // ctx.lineTo(x + width - shift, y);
      // ctx.stroke();
      ctx.fillRect(x + shift, y, CELL_SIZE, CELL_SIZE);
    }
  }

  ctx.globalAlpha = 0.15;
  ctx.drawImage(canvas, 2, 2, canvas.width, canvas.height);
  ctx.drawImage(canvas, -2, 2, canvas.width, canvas.height);
  ctx.drawImage(canvas, -2, -2, canvas.width, canvas.height);
  ctx.drawImage(canvas, 2, -2, canvas.width, canvas.height);

  // update fps
  fps.innerText = Math.round(1000 / delta).toFixed(0) + ' FPS';

  requestAnimationFrame(render);
}

render();
