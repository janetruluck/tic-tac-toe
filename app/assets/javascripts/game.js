var humanPiece        = '';
var aiPiece           = '';
var drawMessage       = "It's a draw! You still lose...technically... Game Over.";
var spaceTakenMessage = "Woah Champ that cell is taken, choose another!";
var humanWinMessage   = "Human Wins OMG You did it! Game Over.";
var aiWinMessage      = "AI wins...typical... Game Over.";
var playerTurnMessage = "Your Turn";
var aiTurnMessage     = "AI's Turn";

$(document).ready(function(){
  $('.start').click(function(){
    startGame($(this).data("player"));
  })

  $(".game-board-grid .col-md-4").click(function() {
    if($(".game-board-grid").hasClass("active")){
      updateStatusHeader(playerTurnMessage);

      var current_col = $(this).data("grid-col");
      var current_row = $(this).data("grid-row");

      // Set the piece on the game board
      if($(this).hasClass("taken")) {
        updateStatusHeader(spaceTakenMessage);
      } else {
        registerMove($(this), humanPiece);
        registerAIMove();
      }
    }
  });
});

function startGame(firstPlayer){
    resetGame();
    if (firstPlayer == 'human'){
        updateStatusHeader(playerTurnMessage);
        humanPiece = 'x';
        aiPiece    = 'o';
    }else{
        updateStatusHeader(aiTurnMessage);
        aiPiece    = 'x';
        humanPiece = 'o';
        registerAIMove();
    }
}

// Sets the selected cell on the board to the correct symbol
function registerMove(cell, piece) {
  $(cell).addClass("taken");

  $(cell).data("value", piece);

  if(piece == "x") {
    $(cell).find("i.fa").addClass("fa-times");
  } else {
    $(cell).find("i.fa").addClass("fa-circle-o");
  }
};

function registerAIMove() {
  updateStatusHeader(aiTurnMessage);
  toggleBoardActiveState();

  $(".fa-stack .fa-spin").show();

  var url  = "/api/ai_move";
  var data = JSON.stringify(currentBoardJson());

  $.ajax({
    url:      url,
    type:     "POST",
    dataType: "json",
    data:     data,
    success: function(data) {
      console.log(data);
      move = data.move;

      if (move) { processAIMove(move) }

      checkForWinner(data.winner, data.draw);
      $(".fa-stack .fa-spin").hide();
    }
  })
};

function processAIMove(move){
  var cell = $(".game-board-grid").
             find("[data-grid-row=\"" + move.row + "\"]" + "[data-grid-col=\"" + move.col+ "\"]");

  registerMove(cell, move.value);
};

function checkForWinner(winningPiece, draw) {
  if(draw){
    updateStatusHeader(drawMessage);
    $(".game-board-grid").removeClass("active");
  } else {
    if (winningPiece == humanPiece) {
      $(".game-board-grid").removeClass("active");
      updateStatusHeader(humanWinMessage);
    } else if (winningPiece == aiPiece) {
      $(".game-board-grid").removeClass("active");
      updateStatusHeader(aiWinMessage);
    } else {
      toggleBoardActiveState();
      updateStatusHeader(playerTurnMessage);
    }
  }
};

function currentBoardJson() {
  var cells = [];

  $(".game-board-grid .col-md-4").each(function(){
    var currentCell = {};

    currentCell.row   = $(this).data("grid-row");
    currentCell.col   = $(this).data("grid-col");
    currentCell.value = $(this).data("value") || null;

    cells.push(currentCell);
  });

  return { piece: aiPiece, cells: cells };
};

function updateStatusHeader(message) {
  $(".status-header").html(message);
};

function resetGame(){
  clearGameBoard();
  setupNewGame();
};

function clearGameBoard(){
  $('.game-board-grid .col-md-4').data("value", null);
  $('.game-board-grid .col-md-4').removeClass("taken");
  $('.game-board-grid .col-md-4 i').removeClass().addClass("fa").addClass("fa-5x");
};

function setupNewGame() {
  $(".game-board-grid").addClass("active");
};

function toggleBoardActiveState() {
  if($(".game-board-grid").hasClass("active")) {
    $(".game-board-grid").removeClass("active")
  } else {
    $(".game-board-grid").addClass("active")
  }
};
