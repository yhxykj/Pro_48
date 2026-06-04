//
//  LocalAIReplyProvider.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/4.
//

import Foundation

enum LocalAIReplyProvider {

    private struct ReplyTemplate {
        let keywords: [String]
        let replies: [String]
    }

    static func reply(for message: String, historyCount: Int) -> String {
        let normalizedMessage = message.lowercased()
        let template = templates.first { template in
            template.keywords.contains { keyword in
                normalizedMessage.contains(keyword.lowercased())
            }
        } ?? fallbackTemplate

        return selectReply(from: template.replies, message: message, historyCount: historyCount)
    }

    private static func selectReply(
        from replies: [String],
        message: String,
        historyCount: Int
    ) -> String {
        guard !replies.isEmpty else { return "" }

        let seed = message.unicodeScalars.reduce(historyCount) { result, scalar in
            result &+ Int(scalar.value)
        }
        let index = Int(seed.magnitude % UInt(replies.count))
        return replies[index]
    }

    private static let templates: [ReplyTemplate] = [
        ReplyTemplate(
            keywords: [
                "work", "job", "resume", "career", "office", "interview",
                "工作", "上班", "简历", "面试", "职业", "事业"
            ],
            replies: [
                "When work feels stuck, don't solve the whole road at once. Choose one thing you can control today, one person you can ask, and one tiny action to start.",
                "That sounds tiring. Let's make it lighter: what is the smallest work step you can finish in the next ten minutes?",
                "You may not need a perfect answer right now. Try writing down what happened, what you need, and the next practical move."
            ]
        ),
        ReplyTemplate(
            keywords: [
                "anxious", "anxiety", "panic", "worried", "stress", "pressure",
                "焦虑", "担心", "紧张", "压力", "慌", "害怕"
            ],
            replies: [
                "Let's slow this down together. Take one easy breath, then name only the next small step. You don't have to carry the whole future at once.",
                "Anxiety often gets louder when everything feels urgent. Pick one thing that is true right now, and one thing you can do gently.",
                "I hear the pressure in this. Put both feet on the floor for a moment, breathe out slowly, and tell me which part feels the heaviest."
            ]
        ),
        ReplyTemplate(
            keywords: [
                "sad", "cry", "hurt", "down", "unhappy", "heartbroken",
                "难过", "伤心", "哭", "低落", "委屈", "崩溃"
            ],
            replies: [
                "I'm here with you. Try naming the feeling first: sadness, disappointment, or exhaustion. Once it has a name, it usually feels a little less heavy.",
                "That sounds painful. You don't need to rush yourself out of it. Tell me what happened, one piece at a time.",
                "Be gentle with yourself tonight. A hard feeling is not a failure; it's a signal that something inside you needs care."
            ]
        ),
        ReplyTemplate(
            keywords: [
                "angry", "mad", "annoyed", "upset", "fight", "argue",
                "生气", "愤怒", "吵架", "烦", "火大", "争吵"
            ],
            replies: [
                "That anger is trying to protect something important. Before you react, give it a little space: what boundary or need is underneath it?",
                "You are allowed to feel angry. Let's keep it from hurting you back. What do you wish the other person understood?",
                "Take a pause before choosing the next move. A calm sentence often has more power than a loud one."
            ]
        ),
        ReplyTemplate(
            keywords: [
                "lonely", "alone", "miss", "empty", "no one",
                "孤独", "一个人", "想念", "空", "没人", "寂寞"
            ],
            replies: [
                "Feeling alone can be really loud. You don't have to fix everything tonight. Stay here with me, and tell me one detail of your day.",
                "I hear you. Loneliness doesn't mean you are unlovable; it means you need connection. Who feels safest to reach out to, even with a small message?",
                "Let's make this moment softer. What would help you feel one percent less alone right now?"
            ]
        ),
        ReplyTemplate(
            keywords: [
                "sleep", "tired", "exhausted", "insomnia", "can't sleep",
                "睡", "失眠", "累", "疲惫", "困", "睡不着"
            ],
            replies: [
                "Your mind may be asking for a softer landing. Put the hardest thought into one sentence, then promise yourself you can revisit it tomorrow.",
                "You sound exhausted. Try lowering the goal: not perfect sleep, just a quieter body for the next few minutes.",
                "Let's release a little tension first. Unclench your jaw, drop your shoulders, and let one long breath leave slowly."
            ]
        ),
        ReplyTemplate(
            keywords: [
                "friend", "relationship", "love", "family", "partner", "crush",
                "朋友", "关系", "喜欢", "恋爱", "家人", "对象", "爱情"
            ],
            replies: [
                "Relationships can feel confusing when you care a lot. Tell me what happened, and we can separate facts, feelings, and the next kind step.",
                "It makes sense that this matters to you. What do you most want from this relationship right now: clarity, comfort, or distance?",
                "Let's protect your heart and your dignity at the same time. What response would feel honest without being too heavy?"
            ]
        ),
        ReplyTemplate(
            keywords: [
                "happy", "good", "excited", "better", "relieved",
                "开心", "高兴", "好多了", "快乐", "兴奋", "放松"
            ],
            replies: [
                "I love that. Keep a small note of this moment, even one sentence. Good feelings deserve a place to stay too.",
                "That's a bright little moment. What made it feel good? Naming it can help you find more of it later.",
                "I'm glad your heart has some room to breathe. Let yourself enjoy it without immediately worrying about what comes next."
            ]
        ),
        ReplyTemplate(
            keywords: [
                "confused", "lost", "don't know", "stuck", "choice", "decide",
                "迷茫", "不知道", "卡住", "选择", "决定", "怎么办"
            ],
            replies: [
                "When you feel lost, we can make the map smaller. What are the two choices in front of you, and which one feels a little more peaceful?",
                "You don't need the whole answer yet. Start with what you know for sure, even if it is only one sentence.",
                "Let's untangle it gently. Tell me the part you understand, the part you fear, and the part you can control."
            ]
        )
    ]

    private static let fallbackTemplate = ReplyTemplate(
        keywords: [],
        replies: [
            "I hear you. Let's stay with this gently: what part of it hurts the most right now?",
            "That sounds like a lot to carry. If we make it smaller, what is the first piece you want to talk through?",
            "I'm with you. Try describing the feeling in three words, then we can find the next step together.",
            "Thank you for telling me. Your feelings make sense here. What do you need most right now: comfort, clarity, or a next step?"
        ]
    )

}
