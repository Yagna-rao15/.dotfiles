import React from "react";

const MessyComponent = () => {
  const handleClick = () => {
    console.log("clicked!");
  };

  return (
    <div className="container">
      <h1> Messy TSX File </h1>
      <button onClick={handleClick}> Click Me </button>
      <ul>
        {/* <li>Item 1</li> <li>Item 2</li> */}
        {/* <li>Item 3</li> */}
      </ul>
      <div className="bg-neutral-500"></div>
    </div>
  );
};

export default MessyComponent;


function test('should first', () => { second })
