//async & await

//clear style of using promise :)

//1. async

async function fetchUser(){
  return 'ellie'
}
  

const user  = fetchUser();
user.then(console.log);


//2. await

function delay(ms){
    return new Promise(resolve => setTimeout(resolve,ms));
}


async function getApple(){
    await delay(1000);
    return 'apple'
}

async function getBanana(){
    await delay(1000);
    return 'banana'
}
async function pickFruits(){
 const applePromise = getApple();
 const bananaPromise = getBanana();
 const apple = await applePromise;
 const banana = await bananaPromise;
 return '${apple}+${banana}';
}

pickFruits().then(console.log)


//3. userful Promis APIs
function pickAllFruits(){
    return Promise.all([getApple(),getBanana()])
    .then(fruits =>fruits.join(' + '))

}
pickAllFruits().then(console.log);

function pickOnlyone(){
    return Promise.race([getApple(),getBanana()])
   

}

pickOnlyone().then(console.log);