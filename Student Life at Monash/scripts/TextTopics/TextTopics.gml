global.topics = {};

global.topics[$ "Default"] = [
	TEXT("Should probably set a better topic")
]

global.topics[$ "Welcome to the Game"] = [
	TEXT("Hello there!"),
	TEXT("Welcome to the Campus of Monash University"),
	TEXT("This place is filled with many activties, classes and clubs to explore and partipate in.")
]

global.topics[$ "Example"] = [
	TEXT("Hello there!"),
	TEXT("Ths is some example text."),
	TEXT("We should test having a page with lots of words in it, to make sure that the line break feature is working properly.")
];

global.topics[$ "Good Morning"] = [
	SPEAKER("Sam", sPortraitSam, PORTRAIT_SIDE.LEFT),
	TEXT("Good morning! How are you today!"),
	SPEAKER("Rudy", sPortraitRudy, PORTRAIT_SIDE.RIGHT),
	TEXT("I'm doing very well! And you?"),
	SPEAKER("Sam", sPortraitSam, PORTRAIT_SIDE.LEFT),
	TEXT("I can't complain, except for one thing..."),
	SPEAKER("Sam", sPortraitSamMad),
	TEXT("The supermarket was out of carrot juice today!")
];

global.topics[$ "Breakfast"] = [
	SPEAKER("Sam", sPortraitSam, PORTRAIT_SIDE.LEFT),
	CHOICE("What do you want for breakfast?",
		OPTION("Eggs", "Chose Eggs"),
		OPTION("Pancakes", "Chose Pancakes"))
];

global.topics[$ "Chose Eggs"] = [
	TEXT("That's a healthy way to start the day!"),
	GOTO("End of Breakfast")
];

global.topics[$ "Chose Pancakes"] = [
	TEXT("Ooh, yummy!"),
	GOTO("End of Breakfast")
];

global.topics[$ "End of Breakfast"] = [
	TEXT("Goodbye, now!")
];